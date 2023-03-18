import UIKit
import SwiftUI

class ConfigViewModel: ObservableObject {
    @Published var character: Character?
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var showingResetAlert = false

    private let charaRepository: CharaRepository = CharaRepository()
    private let userRepository: UserRepository = UserRepository()
    
    var versionString: String {
        return getVersion()
    }
    
    var charaDomain: String {
        guard let characterDomain = charalarmEnvironment.userDefaultsHandler.getCharaDomain() else {
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
        charaRepository.fetchCharacter(charaDomain: charaDomain) { result in
            switch result {
            case let .success(character):
                print(character)
                self.character = character
            case .failure:
                self.alertMessage = "キャラクター情報の取得に失敗しました。"
                self.showingAlert = true
            }
        }
    }
    
    func withdraw() async throws {
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
            let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
            self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                self.showingAlert = true
                return
        }
        
        do {
            try await userRepository.withdraw(userID: anonymousUserName, authToken: anonymousUserPassword)
            try charalarmEnvironment.keychainHandler.setAnonymousUserName(anonymousUserName: "")
            try charalarmEnvironment.keychainHandler.setAnonymousUserPassword(anonymousUserPassword: "")
            charalarmEnvironment.userDefaultsHandler.setCharaDomain(charaDomain: DEFAULT_CHARA_DOMAIN)
            charalarmEnvironment.userDefaultsHandler.setCharaName(charaName: DEFAULT_CHARA_NAME)
        } catch {
            try! charalarmEnvironment.keychainHandler.setAnonymousUserName(anonymousUserName: "")
            try! charalarmEnvironment.keychainHandler.setAnonymousUserPassword(anonymousUserPassword: "")
            charalarmEnvironment.userDefaultsHandler.setCharaDomain(charaDomain: DEFAULT_CHARA_DOMAIN)
            charalarmEnvironment.userDefaultsHandler.setCharaName(charaName: DEFAULT_CHARA_NAME)
            fatalError("Fource Reset")
        }
    }
    
    func resetButtonTapped() {
        showingResetAlert = true
    }
        
    private func getVersion() -> String {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
            let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
                return ""
        }
        return "\(version)(\(build))"
    }
}
