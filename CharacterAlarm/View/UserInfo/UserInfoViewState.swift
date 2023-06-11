import UIKit
import SwiftUI

class UserInfoViewState: ObservableObject {
    @Published var alertMessage = ""
    @Published var showingAlert = false
    @Published var userInfo: UserInfo?
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private let apiRepository = APIRepository()
    private let keychainRepository = KeychainRepository()
    
    var pushToken: String? {
        return appDelegate?.model.pushToken
    }
    
    var voipPushToken: String? {
        return appDelegate?.model.voipPushToken
    }
    
    func fetchUserInfo() {
        Task { @MainActor in
            guard let userID = keychainRepository.getUserID(),
                  let authToken = keychainRepository.getAuthToken() else {
                alertMessage = "不明なエラーです"
                showingAlert = true
                return
            }
            
            do {
                userInfo = try await apiRepository.postUserInfo(userID: userID, authToken: authToken)
            } catch {
                alertMessage = "不明なエラーです"
                showingAlert = true
            }
        }
    }
}

