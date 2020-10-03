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
        CharacterStore.fetchCharacter(charaDomain: characterDomain) { error, character in
            if let error = error {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = error.localizedDescription
                }
                return
            }
            
            guard let character = character else {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = "所得に失敗しました"
                }
                return
            }
            
            DispatchQueue.main.async {
                self.character = character
            }
        }
    }
    
    func withdraw(completion: @escaping () -> Void) {
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
            let anonymousUserPassword = KeychainHandler.getAnonymousUserPassword() else {
                self.showingAlert = true
                self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                return
        }
        
        AnonymousUserStore.withdraw(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword){ error in
            if let error = error {
                self.showErrorAlert(message: "退会処理に失敗しました\n\(error.localizedDescription)")
                return
            }
            
            // ユーザー退会に成功
            do {
                try KeychainHandler.setAnonymousUserName(anonymousUserName: "")
                try KeychainHandler.setAnonymousUserPassword(anonymousUserPassword: "")
            } catch {
                self.showErrorAlert(message: "ユーザー情報の削除に失敗しました\n\(error.localizedDescription)")
                return
            }

            completion()
        }
    }
    
    private func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            self.showingAlert = true
            self.alertMessage = message
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
