import UIKit
import AVFoundation
import Firebase
import UserNotifications
import PushKit
import CallKit
import AVKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var audioPlayer: AVAudioPlayer!
    var player = AVPlayer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        guard let apiEndpoint = Bundle.main.infoDictionary?["API_ENDPOINT"] as? String  else {
            fatalError("API_ENDPOINTが見つかりません")
        }
        API_ENDPOINT = apiEndpoint
        
        
        guard let resourceEndpoint = Bundle.main.infoDictionary?["RESOURCE_ENDPOINT"] as? String  else {
            fatalError("RESOURCE_ENDPOINTが見つかりません")
        }
        RESOURCE_ENDPOINT = resourceEndpoint
        
        UINavigationBar.appearance().tintColor = UIColor(named: "charalarm-default-gray")
        
        // プッシュ通知を要求
        UIApplication.shared.registerForRemoteNotifications()
        
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

        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
            let anonymousUserPassword = KeychainHandler.getAnonymousAuthToken() else {
            return
        }
        
        let pushToken = PushTokenRequest(osType: "IOS", pushTokenType: "REMOTE_NOTIFICATION", pushToken: token)
        PushStore.addPushToken(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, pushToken: pushToken) { result in
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
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
            let anonymousUserPassword = KeychainHandler.getAnonymousAuthToken() else {
            return
        }
        
        let pushToken = PushTokenRequest(osType: "IOS", pushTokenType: "VOIP_NOTIFICATION", pushToken: token)
        PushStore.addVoipPushToken(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, pushToken: pushToken) { result in
            switch result {
            case .success(_):
                break
            case let .failure(error):
                print(error)
            }
        }
    }

    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        let config = CXProviderConfiguration()
        config.iconTemplateImageData = R.image.callAlarm()!.pngData()
        config.includesCallsInRecents = true
        let provider = CXProvider(configuration: config)
        provider.setDelegate(self, queue: nil)
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: UserDefaultsHandler.getCharaName() ?? "キャラーム")
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
        // キャラドメイン
        guard let charaDomain = UserDefaultsHandler.getCharaDomain() else {
            return
        }

        // リソース取得
        guard let data = try? FileHandler.loadData(directoryName: charaDomain, fileName: "resource.json") else {
            return
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let resource = try? decoder.decode(Resource.self, from: data) else {
            return
        }

        guard let key = resource.call.keys.randomElement() else {
            return
        }

        guard let voiceName = resource.call[key]?.voices.randomElement() else {
            return
        }

        do {
            let data = try FileHandler.loadData(directoryName: charaDomain, fileName: voiceName)
            audioPlayer = try? AVAudioPlayer(data: data)
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fulfill()
    }
}
