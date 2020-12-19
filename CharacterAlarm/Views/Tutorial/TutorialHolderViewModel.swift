import Foundation

class TutorialHolderViewModel: ObservableObject {
    let anonymousUserName = UUID().uuidString
    let anonymousUserPassword = UUID().uuidString
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func signUp() {
        UserStore.signup(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword){ result in
            switch result {
            case .success(_):
                // ユーザー作成に成功
                do {
                    try KeychainHandler.setAnonymousUserName(anonymousUserName: self.anonymousUserName)
                    try KeychainHandler.setAnonymousUserPassword(anonymousUserPassword: self.anonymousUserPassword)
                } catch {
                    self.alertMessage = "ユーザー情報の保存に設定に失敗しました。"
                    self.showingAlert = true
                }
                break
            case .failure:
                self.alertMessage = "サーバーとの通信に失敗しました。"
                self.showingAlert = true
            }
        }
    }
}
