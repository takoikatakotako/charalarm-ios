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
    let pushRepository: PushRepository = PushRepository()

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
        
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let optionalPushToken = delegate?.model.pushToken
        let optionalVoIPPushToken = delegate?.model.voipPushToken
        
        Task { @MainActor in
            // ここでユーザー登録してトークンを設定する
            do {
                // SignUp
                try await userRepository.signup(userID: anonymousUserName, authToken: anonymousUserPassword)
                
                // Set KeyChain
                try charalarmEnvironment.keychainHandler.setAnonymousUserName(anonymousUserName: self.anonymousUserName)
                try charalarmEnvironment.keychainHandler.setAnonymousUserPassword(anonymousUserPassword: self.anonymousUserPassword)
                
                // Set Push Token
                if let token = optionalPushToken {
                    let pushToken = PushTokenRequest(osType: "IOS", pushTokenType: "REMOTE_NOTIFICATION", pushToken: token)
                    _ = try await pushRepository.addPushToken(anonymousUserName: self.anonymousUserName, anonymousUserPassword: self.anonymousUserPassword, pushToken: pushToken)
                }
    
                // Set VoIP Push Token
                if let token = optionalVoIPPushToken {
                    let voipPushToken = PushTokenRequest(osType: "IOS", pushTokenType: "VOIP_NOTIFICATION", pushToken: token)
                    _ = try await pushRepository.addVoipPushToken(anonymousUserName: self.anonymousUserName, anonymousUserPassword: self.anonymousUserPassword, pushToken: voipPushToken)
                }
                
                self.accountCreated = true
            } catch {
                self.alertMessage = R.string.localizable.tutorialFailedToSaveUserInformation()
                self.showingAlert = true
            }
            self.creatingAccount = false
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
