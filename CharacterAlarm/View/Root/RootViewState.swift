import UIKit
import SwiftUI

class RootViewState: ObservableObject {
    @Published var type: RootViewType = .loading
    private let otherRepository = OtherRepository()
    private let appUseCase = AppUseCase()
    
    func onAppear() {
        Task { @MainActor in
            do {
                // ローディング中（初回起動）のみ先に進む
                guard type == .loading else {
                    return
                }
                
                // メンテナンス中か確認
                let isMaintenance = try await otherRepository.fetchMaintenance()
                if isMaintenance {
                    withAnimation(.linear(duration: 1)) {
                        type = .maintenance
                    }
                    return
                }
                
                // アップデートが必要か確認
                let requireVersion = try await otherRepository.fetchRequireVersion()
                if requireVersion > appUseCase.appVersion {
                    withAnimation(.linear(duration: 1)) {
                        type = .updateRequire
                    }
                    return
                }
                
                // チュートリアルの状態を確認
                if appUseCase.isDoneTutorial {
                    withAnimation(.linear(duration: 1)) {
                        type = .top
                    }
                } else {
                    withAnimation(.linear(duration: 1)) {
                        type = .tutorial
                    }
                }
            } catch {
                
            }
        }
    }
    
    func doneTutorial() {
        withAnimation(.linear(duration: 1)) {
            type = .top
        }
    }
    
    func didReset() {
        withAnimation(.linear(duration: 1)) {
            type = .tutorial
        }
    }
    
    func answerCall() {
        type = .calling
    }
    
    func endCall() {
        type = .top
    }
}
