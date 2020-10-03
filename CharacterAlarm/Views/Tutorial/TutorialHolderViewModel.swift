import Foundation

class TutorialHolderViewModel: ObservableObject {
    let anonymousUserName = UUID().uuidString
    let anonymousUserPassword = UUID().uuidString
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func signUp() {
        AnonymousUserStore.signup(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword){ error in
            if let error = error {
                self.showErrorAlert(message: "サーバーとの通信に失敗しました\n" + error.localizedDescription)
                return
            }
            
            // ユーザー作成に成功
            do {
                try KeychainHandler.setAnonymousUserName(anonymousUserName: self.anonymousUserName)
                try KeychainHandler.setAnonymousUserPassword(anonymousUserPassword: self.anonymousUserPassword)
            } catch {
                self.showErrorAlert(message: "ユーザー情報の保存に設定しました\n" + error.localizedDescription)
            }
        }
    }
    
    private func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            self.showingAlert = true
            self.alertMessage = message
        }
    }
}
