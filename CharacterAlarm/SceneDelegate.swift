import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var rootViewController: UIViewController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // キャラクターの初期値のDomainを登録
        UserDefaultsHandler.registerDefaults(defaults: [CHARA_DOMAIN : DEFAULT_CHARA_DOMAIN, CHARA_NAME: DEFAULT_CHARA_NAME])
        
        // 
        guard let charaDomain = UserDefaultsHandler.getCharaDomain()  else {
            fatalError("キャラクターのドメインの取得に失敗しました")
        }
        if let data = try? FileHandler.loadData(directoryName: charaDomain, fileName: "resource.json"),
           let resource: Resource = try? JSONDecoder().decode(Resource.self, from: data){
            print(resource.version)
            // TODO: 選択中のキャラクターの最新リソースがある場合更新する
        } else {
            // データをロード
            if let filePath = Bundle.main.path(forResource: "resource", ofType: "json", inDirectory: "com.charalarm.yui"),
               let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
               let resource: Resource = try? JSONDecoder().decode(Resource.self, from: data) {
                xxx(charaDomain: charaDomain, resource: resource)
            }
        }
        
        
        //
        
        let anonymousUserName = KeychainHandler.getAnonymousUserName()
        let anonymousUserPassword = KeychainHandler.getAnonymousUserPassword()
        
        // 匿名ユーザー名、パスワードが登録されていればチュートリアル完了
        let doneTutorial = anonymousUserName != nil && anonymousUserPassword != nil
        
        let rootView = RootView()
        let charalarmAppState = CharalarmAppState()
        charalarmAppState.doneTutorial = doneTutorial
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            rootViewController = UIHostingController(rootView: rootView.environmentObject(charalarmAppState))
            window.rootViewController = self.rootViewController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func xxx(charaDomain:String, resource: Resource) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(resource)
            try FileHandler.saveFile(directoryName: charaDomain, fileName: "resource.json", data: data)
        } catch {
            return
        }
        
        for imageName in resource.resource.images {
            let xxx = imageName.split(separator: ".")
            do {
                let fileName: String = String(xxx[0])
                let type: String = String(xxx[1])
                let filePath = Bundle.main.path(forResource: fileName, ofType: type, inDirectory: "com.charalarm.yui/image")!
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                try FileHandler.saveFile(directoryName: charaDomain, fileName: imageName, data: data)
            } catch {
                
            }
        }
        
        for voiceName in resource.resource.voices {
            let xxx = voiceName.split(separator: ".")
            do {
                let fileName: String = String(xxx[0])
                let type: String = String(xxx[1])
                let filePath = Bundle.main.path(forResource: fileName, ofType: type, inDirectory: "com.charalarm.yui/voice")!
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                try FileHandler.saveFile(directoryName: charaDomain, fileName: voiceName, data: data)
            } catch {
                
            }
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
}
