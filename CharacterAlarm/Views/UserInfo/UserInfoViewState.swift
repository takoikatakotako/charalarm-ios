import UIKit
import SwiftUI

class UserInfoViewState: ObservableObject {
    @Published var alertMessage = ""
    @Published var showingAlert = false
    @Published var userInfo: UserInfo?
    
    private let userRepository = UserRepository()
    func fetchUserInfo() {
        Task { @MainActor in
            guard let userID = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
                  let authToken = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
                self.alertMessage = "不明なエラーです"
                self.showingAlert = true
                return
            }
            
            do {
                userInfo = try await userRepository.info(userID: userID, authToken: authToken)
            } catch {
                self.alertMessage = "不明なエラーです"
                self.showingAlert = true
            }
        }
    }
}

