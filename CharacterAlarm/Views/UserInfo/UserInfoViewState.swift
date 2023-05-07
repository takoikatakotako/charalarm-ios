import UIKit
import SwiftUI

class UserInfoViewState: ObservableObject {
    @Published var alertMessage = ""
    @Published var showingAlert = false
    @Published var userInfo: UserInfo?
    
    private let userRepository = UserRepository()
    private let keychainRepository = KeychainRepository()
    
    func fetchUserInfo() {
        Task { @MainActor in
            guard let userID = keychainRepository.getUserID(),
                  let authToken = keychainRepository.getAuthToken() else {
                alertMessage = "不明なエラーです"
                showingAlert = true
                return
            }
            
            do {
                userInfo = try await userRepository.info(userID: userID, authToken: authToken)
            } catch {
                alertMessage = "不明なエラーです"
                showingAlert = true
            }
        }
    }
}

