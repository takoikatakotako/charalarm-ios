import UIKit
import AVKit

class AppDelegateModel {
    private(set) var charaName: String = ""
    private(set) var voiceFileURL: String = ""
    private var player = AVPlayer()
    private let pushRepository: PushRepository
    private let keychainRepository: KeychainRepository
    var pushToken: String?
    var voipPushToken: String?
    
    init(pushRepository: PushRepository, keychainRepository: KeychainRepository) {
        self.pushRepository = PushRepository()
        self.keychainRepository = KeychainRepository()
    }
    
    func setCharaName(charaName: String) {
        self.charaName = charaName
    }
    
    func setVoiceFileURL(voiceFileURL: String) {
        self.voiceFileURL = voiceFileURL
    }
    
    // MARK: - Push Notification
    // Pushトークンを登録
    func registerPushToken(token: String) {
        self.pushToken = token
    
        guard let userID = keychainRepository.getUserID(),
              let authToken = keychainRepository.getAuthToken() else {
            return
        }
        
        Task {
            do {
                let pushTokenRequest = PushTokenRequest(osType: "IOS", pushTokenType: "REMOTE_NOTIFICATION", pushToken: token)
                try await pushRepository.addPushToken(userID:userID, authToken: authToken, pushToken: pushTokenRequest)
            } catch {
                print(error)
            }
        }
    }
    
    // ViIPPushトークンを取得できなかった場合
    func failToRregisterPushToken(error: Error) {
        print("Failed to register to APNs: \(error)")
    }
    
    
    // MARK: - Voip Push Notification
    // VoIP Pushトークンを登録
    func registerVoipPushToken(token: String) {
        self.voipPushToken = token

        guard let userID = keychainRepository.getUserID(),
              let authToken = keychainRepository.getAuthToken() else {
            return
        }
        
        Task {
            do {
                let pushTokenRequest = PushTokenRequest(osType: "IOS", pushTokenType: "VOIP_NOTIFICATION", pushToken: token)
                try await pushRepository.addVoipPushToken(userID:userID, authToken: authToken, pushToken: pushTokenRequest)
            } catch {
                print(error)
            }
        }
    }
    
    // VoIP Pushを受信
    func receiveVoipPush() {
        if let url = URL(string: voiceFileURL) {
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player.play()
        }
    }
}
