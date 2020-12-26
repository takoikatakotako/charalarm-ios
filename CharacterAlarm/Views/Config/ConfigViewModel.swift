import UIKit
import SwiftUI

class ConfigViewModel: ObservableObject {
    @Published var character: Character?
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    var versionString: String {
        return getVersion()
    }
    
    var charaDomain: String {
        guard let characterDomain = UserDefaultsHandler.getCharaDomain() else {
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
        CharacterStore.fetchCharacter(charaDomain: charaDomain) { result in
            switch result {
            case let .success(character):
                print(character)
                self.character = character
            case let .failure(error):
                self.alertMessage = "キャラクター情報の取得に失敗しました。"
                self.showingAlert = true
            }
        }
    }
    
    func withdraw(completion: @escaping () -> Void) {
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
            let anonymousUserPassword = KeychainHandler.getAnonymousUserPassword() else {
            self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                self.showingAlert = true
                return
        }
        
        UserStore.withdraw(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword){ _ in
            do {
                try KeychainHandler.setAnonymousUserName(anonymousUserName: "")
                try KeychainHandler.setAnonymousUserPassword(anonymousUserPassword: "")
                UserDefaultsHandler.setCharaDomain(charaDomain: DEFAULT_CHARA_DOMAIN)
                UserDefaultsHandler.setCharaName(charaName: DEFAULT_CHARA_NAME)
                completion()
            } catch {
                try! KeychainHandler.setAnonymousUserName(anonymousUserName: "")
                try! KeychainHandler.setAnonymousUserPassword(anonymousUserPassword: "")
                UserDefaultsHandler.setCharaDomain(charaDomain: DEFAULT_CHARA_DOMAIN)
                UserDefaultsHandler.setCharaName(charaName: DEFAULT_CHARA_NAME)
                fatalError("Fource Reset")
            }
        }
    }
        
    private func getVersion() -> String {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
            let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
                return ""
        }
        return "\(version)(\(build))"
    }
}
