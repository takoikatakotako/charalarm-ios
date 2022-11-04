import UIKit
import AVKit

class AppDelegateModel {
    private(set) var charaName: String = ""
    private(set) var filePath: String = ""
    private var player = AVPlayer()
    private let pushRepository: PushRepository
    private let keychainHandler: KeychainHandlerProtcol
    
    init(pushRepository: PushRepository, keychainHandler: KeychainHandlerProtcol) {
        self.pushRepository = PushRepository()
        self.keychainHandler = KeychainHandler()
    }
    
    func setCharaName(charaName: String) {
        self.charaName = charaName
    }
    
    func setFilePath(filePath: String) {
        self.filePath = filePath
    }
    
    // MARK: - Push Notification
    // Pushトークンを登録
    func registerPushToken(token: String) {        
        guard let anonymousUserName = keychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = keychainHandler.getAnonymousAuthToken() else {
            return
        }
        
        let pushToken = PushTokenRequest(osType: "IOS", pushTokenType: "REMOTE_NOTIFICATION", pushToken: token)
        pushRepository.addPushToken(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, pushToken: pushToken) { result in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        }
    }
    
    // Pushトークンを取得できなかった場合
    func failToRregisterVoipPushToken(error: Error) {
        print("Failed to register to APNs: \(error)")
    }
    
    
    // MARK: - Voip Push Notification
    // VoIP Pushトークンを登録
    func registerVoipPushToken(token: String) {
        guard let anonymousUserName = keychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = keychainHandler.getAnonymousAuthToken() else {
            return
        }
        
        let pushToken = PushTokenRequest(osType: "IOS", pushTokenType: "VOIP_NOTIFICATION", pushToken: token)
        pushRepository.addVoipPushToken(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, pushToken: pushToken) { result in
            switch result {
            case .success(_):
                break
            case let .failure(error):
                print(error)
            }
        }
    }
    
    // VoIP Pushを受信
    func receiveVoipPushToken() {
        if let url = URL(string: RESOURCE_ENDPOINT + filePath) {
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player.play()
        }
    }
}
