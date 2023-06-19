import UIKit
import SwiftUI

class RootViewState: ObservableObject {
    @Published var type: RootViewType = .loading
    var callUUID: UUID?
    
    private let apiRepository = APIRepository()
    private let appUseCase = AppUseCase()
    private let charaUseCase = CharaUseCase()
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
                let exists = try charaUseCase.isExistDefaultCharaDirectory()
                if exists == false {
                    try charaUseCase.copyToDefaultCharaDirectory()
                }
                
                // デコードできるかチェックする
                if let localCharaReesource = try? charaUseCase.loadLocalCharaReesource() {
                    // 最新更新できるかチェックする
                    try await charaUseCase.checkUpdateCharaResource(charaID: localCharaReesource.charaID, updatedAt: localCharaReesource.updatedAt)
                } else {
                    // 最新版を落とす
                    try await charaUseCase.fetchAndDownloadCharaResource()
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
                withAnimation(.linear(duration: 1)) {
                    type = .error
                }
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
    
    func answerCall(callUUID: UUID?) {
        type = .calling
        self.callUUID = callUUID
    }
    
    func endCall() {
        type = .top
    }
}
