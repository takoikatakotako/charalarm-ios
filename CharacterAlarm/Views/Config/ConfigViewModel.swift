import UIKit
import SwiftUI

class ConfigViewModel: ObservableObject {
    @Published var character: Chara?
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var showingResetAlert = false

    private let charaRepository: CharaRepository = CharaRepository()
    private let userRepository: UserRepository = UserRepository()
    private let keychainRepository: KeychainRepository = KeychainRepository()
    private let userDefaultsRepository = UserDefaultsRepository()
    private let appUseCase = AppUseCase()

    var versionString: String {
        return getVersion()
    }
    
    var charaDomain: String {
        guard let characterDomain = userDefaultsRepository.getCharaDomain() else {
            fatalError("CHARA_DOMAIN が取得できませんでした")
        }
        return characterDomain
    }
    
    func openUrlString(string: String) {
        guard let url = URL(string: string) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func fetchCharacter() {
//        Task { @MainActor in
//            do {
//                // let chara = try await charaRepository.fetchCharacter(charaID: charaDomain)
//                self.character = character
//            } catch {
//                self.alertMessage = "キャラクター情報の取得に失敗しました。"
//                self.showingAlert = true
//            }
//        }
    }
    
    func withdraw() async throws {
        guard let userID = keychainRepository.getUserID(),
            let authToken = keychainRepository.getAuthToken() else {
            self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                self.showingAlert = true
                return
        }
        
        do {
            try await userRepository.withdraw(userID: userID, authToken: authToken)
            try keychainRepository.setUserID(userID: nil)
            try keychainRepository.setAuthToken(authToken: nil)
            userDefaultsRepository.setCharaDomain(charaDomain: DEFAULT_CHARA_DOMAIN)
            userDefaultsRepository.setCharaName(charaName: DEFAULT_CHARA_NAME)
        } catch {
            try! keychainRepository.setUserID(userID: nil)
            try! keychainRepository.setAuthToken(authToken: nil)
            userDefaultsRepository.setCharaDomain(charaDomain: DEFAULT_CHARA_DOMAIN)
            userDefaultsRepository.setCharaName(charaName: DEFAULT_CHARA_NAME)
            fatalError("Fource Reset")
        }
    }
    
    func resetButtonTapped() {
        showingResetAlert = true
    }
        
    private func getVersion() -> String {
        return "\(appUseCase.appVersion)(\(appUseCase.appBuild))"
    }
}
