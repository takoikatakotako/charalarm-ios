import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var rootViewController: UIViewController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // キャラクターID、匿名ユーザーID、匿名ユーザーパスワードを登録
        UserDefaults.standard.register(defaults: [CHARACTER_DOMAIN : DEFAULT_CHARACTER_DOMAIN])
        let characterId = UserDefaultsHandler.getCharacterDomain()
        
        let anonymousUserName = KeychainHandler.getAnonymousUserName()
        let anonymousUserPassword = KeychainHandler.getAnonymousUserPassword()
    
        let doneTutorial = anonymousUserName != nil && anonymousUserPassword != nil

        let rootView = RootView()
        let charalarmAppState = CharalarmAppState()
        charalarmAppState.doneTutorial = doneTutorial
        charalarmAppState.charaDomain = characterId

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            rootViewController = UIHostingController(rootView: rootView.environmentObject(charalarmAppState))
            window.rootViewController = self.rootViewController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func startCall() {
        //        let view = UIView()
        //        if let frame = rootViewController?.view.bounds {
        //            view.frame = frame
        //        }
        //        view.backgroundColor = .red
        //        rootViewController?.view.addSubview(view)
        
        self.window?.rootViewController = UIHostingController(rootView: CallingView())
    }
    
    func endCall() {
        self.window?.rootViewController = rootViewController
    }
}
