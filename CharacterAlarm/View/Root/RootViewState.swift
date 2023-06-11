import UIKit
import SwiftUI

class RootViewState: ObservableObject {
    @Published var type: RootViewType = .loading
    private let apiRepository = APIRepository()
    private let appUseCase = AppUseCase()
    private let userDefaultsRepository = UserDefaultsRepository()
    private let fileRepository: FileRepositoryProtcol = FileRepository()
    
    func onAppear() {
        Task { @MainActor in
            do {
                // ローディング中（初回起動）のみ先に進む
                guard type == .loading else {
                    return
                }
                
                // メンテナンス中か確認
                let isMaintenance = try await apiRepository.fetchMaintenance()
                if isMaintenance {
                    withAnimation(.linear(duration: 1)) {
                        type = .maintenance
                    }
                    return
                }
                
                // アップデートが必要か確認
                let requireVersion = try await apiRepository.fetchRequireVersion()
                if requireVersion > appUseCase.appVersion {
                    withAnimation(.linear(duration: 1)) {
                        type = .updateRequire
                    }
                    return
                }
                
                // UserDefaults に初期値を入れる
                userDefaultsRepository.registerDefaults()
                
                // 初期ファイルが配置済みか確認する
                let exists = try fileRepository.isExistDirectory(directoryName: "com.charalarm.yui")
                if exists == false {
                    // Bundle.main.url(forResource: "resource", withExtension: "json", subdirectory: "Resource/com.charalarm.yui"),
                    // ここでファイルをコピーする
                }
                
                // デコードできるかチェックする
                // fileRepository.loadData(directoryName: <#T##String#>, fileName: <#T##String#>)
                
                
                // 最新更新できるかチェックする
                
                
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
