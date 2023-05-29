import UIKit
import SwiftUI

class RootViewState: ObservableObject {
    @Published var type: RootViewType = .loading
    private let otherRepository = OtherRepository()
    private let authUseCase = AppUseCase()
    
    
    func onAppear() {
        Task { @MainActor in
            do {
                // メンテナンス中か確認
                let isMaintenance = try await otherRepository.fetchMaintenance()
                if isMaintenance {
                    type = .maintenance
                    return
                }
                
                // アップデートが必要か確認
                let requireVersion = try await otherRepository.fetchRequireVersion()
                guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
                    return
                }
                if requireVersion > currentVersion {
                    type = .updateRequire
                    return
                }
                
                // チュートリアルの状態を確認
                if authUseCase.isDoneTutorial {
                    type = .top
                } else {
                    type = .tutorial
                }
            } catch {
                
            }
        }
    }
}
