import Foundation

class TutorialHolderViewModel: ObservableObject {
    let anonymousUserName = UUID().uuidString
    let anonymousUserPassword = UUID().uuidString
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func signUp() {
        AnonymousUserStore.signup(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword){ error in
            if let error = error {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = error.localizedDescription
                }
                return
            }
            
            // ユーザー作成に成功
            do {
                try KeychainHandler.setAnonymousUserName(anonymousUserName: self.anonymousUserName)
                try KeychainHandler.setAnonymousUserPassword(anonymousUserPassword: self.anonymousUserPassword)
            } catch {
                fatalError("エラーハンドリングをきちんとする")
            }
        }
    }
}
