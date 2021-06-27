import UIKit
import AVFoundation
import Firebase
import UserNotifications
import PushKit
import CallKit
import AVKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var player = AVPlayer()
    let pushRepository: PushRepository = PushRepository()
    
    var charaName: String = ""
    var filePath: String = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Use Firebase library to configure APIs.
        FirebaseApp.configure()
        
        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // Endpointをパース
        guard let apiEndpoint = Bundle.main.infoDictionary?["API_ENDPOINT"] as? String,
              let resourceEndpoint = Bundle.main.infoDictionary?["RESOURCE_ENDPOINT"] as? String
        else {
            fatalError("API_ENDPOINTが見つかりません")
        }
        API_ENDPOINT = apiEndpoint
        RESOURCE_ENDPOINT = resourceEndpoint
        
        // Admob周りの処理
        guard let admobAlarmListUnitId = Bundle.main.infoDictionary?["ADMOB_ALARM_LIST"] as? String,
              let admobConfigUnitId = Bundle.main.infoDictionary?["ADMOB_CONFIG"] as? String else {
            fatalError("AdmobのUnitIdが見つかりません")
        }
        AdmobAlarmListUnitId = admobAlarmListUnitId
        AdmobConfigUnitId = admobConfigUnitId
        
        UINavigationBar.appearance().tintColor = UIColor(named: "charalarm-default-gray")
        
        // プッシュ通知を要求
        UIApplication.shared.registerForRemoteNotifications()
        
        let logger = Logger()
        logger.sendLog(message: "test message")
        
        // VoIP Pushを要求
        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: nil)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.mixWithOthers)
            NSLog("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            NSLog("Session is Active")
        } catch {
            NSLog("ERROR: CANNOT PLAY MUSIC IN BACKGROUND. Message from code: \"\(error)\"")
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// Push Notification
extension AppDelegate {
    // プッシュ通知の利用登録が成功した場合
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
        print("Device token: \(token)")
        
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
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
    
    // プッシュ通知の利用登録が失敗した場合
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register to APNs: \(error)")
    }
}

// VoIP Push Notification
extension AppDelegate: PKPushRegistryDelegate {
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        let token = pushCredentials.token.map { String(format: "%02.2hhx", $0) }.joined()
        print(token)
        print(pushCredentials.token)
        
        
        
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
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
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        
        let logger = Logger()
        
        if let aps = payload.dictionaryPayload["aps"] as? NSDictionary,
           let alert = aps["alert"] as? String,
           let data = alert.data(using: .utf8),
           let dataDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
           let charaNeme = dataDictionary["charaName"],
           let filePath = dataDictionary["filePath"] {
            logger.sendLog(message: "charaNeme: \(charaNeme)")
            logger.sendLog(message: "filePath: \(filePath)")
            self.charaName = charaNeme
            self.filePath = filePath
        }
           
        
        
//        // ペイロードのパース
//        if let aps = payload.dictionaryPayload["aps"] as? NSDictionary {
//            logger.sendLog(message: "aps: \(aps.description)")
//            self.charaName = "APS取れてる"
//
//            if let alert = aps["alert"] as? String {
//                logger.sendLog(message: "alert: \(alert.description)")
//                self.charaName = "Alert取れてる"
//
//                if let data = alert.data(using: .utf8),
//                   let dataDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//
//
//                    logger.sendLog(message: "dictionary: \(dataDictionary.description)")
//                    self.charaName = "Dictionaryいけてる"
//
//
//                    if let charaNeme = dataDictionary["charaName"] as? String,
//                       let filePath = dataDictionary["filePath"] as? String {
//
//                        logger.sendLog(message: "charaNeme: \(charaNeme)")
//                        logger.sendLog(message: "filePath: \(filePath)")
//
//
//                        self.charaName = charaNeme
//                        self.filePath = filePath
//
//
//
//
//                    }
//
//
//
//                }
//
//
//            }
//            // self.filePath = filePath
//        }
        //           let alert = aps["alert"] as? NSDictionary,
        //           let charaName = alert["charaName"] as? String,
        //           let filePath = alert["filePath"] as? String {
        //            self.charaName = charaName
        //            self.filePath = filePath
        //        }
        
        let config = CXProviderConfiguration()
        config.iconTemplateImageData = R.image.callAlarm()!.pngData()
        config.includesCallsInRecents = true
        let provider = CXProvider(configuration: config)
        provider.setDelegate(self, queue: nil)
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: charaName)
        provider.reportNewIncomingCall(with: UUID(), update: update, completion: { error in })
    }
}

extension AppDelegate: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) {
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        if let url = URL(string: RESOURCE_ENDPOINT + filePath) {
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player.play()
        }
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fulfill()
    }
}
