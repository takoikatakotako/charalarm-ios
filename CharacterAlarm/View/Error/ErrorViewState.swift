import SwiftUI

class ErrorViewState: ObservableObject {
    private let keychainRepository = KeychainRepository()
    
    func reset() {
        do {
            try keychainRepository.setUserID(userID: nil)
            try keychainRepository.setAuthToken(authToken: nil)
            NotificationCenter.default.post(name: NSNotification.didReset, object: self, userInfo: nil)
        } catch {
            // TODO: エラーハンドリング
        }
    }
}
