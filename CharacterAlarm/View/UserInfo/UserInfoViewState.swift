import UIKit
import SwiftUI

class UserInfoViewState: ObservableObject {
    @Published private var tapCount: Int = 0
    @Published var userInfo: UserInfo?
    @Published var alert: UserInfoAlertItem?
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private let apiRepository = APIRepository()
    private let keychainRepository = KeychainRepository()
    
    var showHidenInfos: Bool {
        return tapCount > 4
    }
    
    var userID: String {
        return keychainRepository.getUserID() ?? "Not Found..."
    }
    
    var authToken: String {
        if let authToken = keychainRepository.getAuthToken() {
            // セキュリティのために全て表示しない
            return String(authToken.prefix(3)) + "***-****-****-****-****************"
        } else {
            return "Not Found..."
        }
    }
    
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
                alert = UserInfoAlertItem(message: "認証情報の取得に失敗しました")
                return
            }
            
            do {
                userInfo = try await apiRepository.postUserInfo(userID: userID, authToken: authToken)
            } catch {
                alert = UserInfoAlertItem(message: "ユーザー情報の取得に失敗しました")
            }
        }
    }
    
    func tapHidenButton() {
        tapCount += 1
    }
}

