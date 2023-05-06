import SwiftUI
import AdSupport
import AppTrackingTransparency

class TutorialAcceptPrivacyPolicyViewModel: ObservableObject {
    @Published var accountCreated = false
    @Published var creatingAccount = false
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    private let userID = UUID()
    private let authToken = UUID()
    private let userRepository: UserRepository = UserRepository()
    private let pushRepository: PushRepository = PushRepository()
    private let keychainRepository: KeychainRepository = KeychainRepository()

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
                try await userRepository.signup(request: UserSignUpRequest(userID: userID.uuidString, authToken: authToken.uuidString, platform: "iOS"))

                // Set KeyChain
                try keychainRepository.setUserID(userID: userID)
                try keychainRepository.setAuthToken(authToken: authToken)
                
                // Set Push Token
                if let token = optionalPushToken {
                    let pushToken = PushTokenRequest(osType: "IOS", pushTokenType: "REMOTE_NOTIFICATION", pushToken: token)
                    try await pushRepository.addPushToken(userID: userID.uuidString, authToken: userID.uuidString, pushToken: pushToken)
                }
    
                // Set VoIP Push Token
                if let token = optionalVoIPPushToken {
                    let voipPushToken = PushTokenRequest(osType: "IOS", pushTokenType: "VOIP_NOTIFICATION", pushToken: token)
                    try await pushRepository.addVoipPushToken(userID: userID.uuidString, authToken: authToken.uuidString, pushToken: voipPushToken)
                }
                
                accountCreated = true
            } catch {
                alertMessage = R.string.localizable.tutorialFailedToSaveUserInformation()
                showingAlert = true
            }
            creatingAccount = false
        }
    }
    
    private func trackingAuthorizationNotDetermined() -> Bool {
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
