import SwiftUI
import AdSupport
import AppTrackingTransparency

class TutorialAcceptPrivacyPolicyViewModel: ObservableObject {
    @Published var accountCreated = false
    @Published var creatingAccount = false
    @Published var showingAlert = false
    @Published var alertMessage = ""
    let anonymousUserName = UUID().uuidString
    let anonymousUserPassword = UUID().uuidString
    let userRepository: UserRepository = UserRepository()
    
    func openPrivacyPolicy() {
        guard let url = URL(string: PrivacyPolicyUrlString) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func signUp() {
        guard !creatingAccount else {
            return
        }
        
        creatingAccount = true
        
        Task {
            // ここでユーザー登録してトークンを設定する
            
        }

        
        userRepository.signup(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword){ result in
            switch result {
            case .success(_):
                // ユーザー作成に成功
                do {
                    try charalarmEnvironment.keychainHandler.setAnonymousUserName(anonymousUserName: self.anonymousUserName)
                    try charalarmEnvironment.keychainHandler.setAnonymousUserPassword(anonymousUserPassword: self.anonymousUserPassword)
                    self.accountCreated = true
                } catch {
                    self.alertMessage = R.string.localizable.tutorialFailedToSaveUserInformation()
                    self.showingAlert = true
                }
                self.creatingAccount = false
                break
            case .failure:
                self.alertMessage = R.string.localizable.commonFailedToConnectWithTheServer()
                self.showingAlert = true
                self.creatingAccount = false
                break
            }
        }
    }
    
    func trackingAuthorizationNotDetermined() -> Bool {
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .authorized:
            return false
        case .denied:
            return false
        case .restricted:
            return false
        case .notDetermined:
            return true
        @unknown default:
            return false
        }
    }
}
