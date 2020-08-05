import Foundation

fileprivate struct Dispachers {
    let settingDispacher = SettingActionDispacher()
}

fileprivate let dispachers = Dispachers()

class TutorialHolderViewModel: ObservableObject {
    let anonymousUserName = UUID().uuidString
    let anonymousUserPassword = UUID().uuidString
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func signUp() {
        AnonymousUserStore.signup(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword){ error in
            if let error = error {
                self.showingAlert = true
                self.alertMessage = error.localizedDescription
                return
            }
            
            // ユーザー作成に成功
            UserDefaults.standard.set(self.anonymousUserName, forKey: ANONYMOUS_USER_NAME)
            UserDefaults.standard.set(self.anonymousUserPassword, forKey: ANONYMOUS_USER_PASSWORD)
        }
    }
}
