import UIKit
import SwiftUI

class ConfigViewModel: ObservableObject {
    @Published var character: Character?
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    var versionString: String {
        return getVersion()
    }
    
    func openUrlString(string: String) {
        guard let url = URL(string: string) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func fetchCharacter(characterDomain: String) {
        CharacterStore.fetchCharacter(charaDomain: characterDomain) { result in
            switch result {
            case let .success(character):
                self.character = character
            case let .failure(error):
                self.alertMessage = error.localizedDescription
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
        
        AnonymousUserStore.withdraw(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword){ result in
            switch result {
            case .success(_):
                do {
                    try KeychainHandler.setAnonymousUserName(anonymousUserName: "")
                    try KeychainHandler.setAnonymousUserPassword(anonymousUserPassword: "")
                    completion()
                } catch {
                    self.alertMessage = "ユーザー情報の削除に失敗しました\n\(error.localizedDescription)"
                    self.showingAlert = true
                }
                
            case let .failure(error):
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
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
