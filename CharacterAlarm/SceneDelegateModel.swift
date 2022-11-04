import UIKit
import AVKit

class SceneDelegateModel {
    private let fileHandler: FileHandlerProtcol
    private let userDefaultsHandler: UserDefaultsHandlerProtocol
    private let keychainHandler: KeychainHandlerProtcol

    init(
        fileHandler: FileHandlerProtcol = FileHandler(),
        userDefaultsHandler: UserDefaultsHandlerProtocol = UserDefaultsHandler(),
        keychainHandler: KeychainHandlerProtcol = KeychainHandler()
    ) {
        self.fileHandler = fileHandler
        self.userDefaultsHandler = userDefaultsHandler
        self.keychainHandler = keychainHandler
    }
    
    func registerDefaults() {
        userDefaultsHandler.registerDefaults(defaults: [CHARA_DOMAIN : DEFAULT_CHARA_DOMAIN, CHARA_NAME: DEFAULT_CHARA_NAME])
    }
    
    func loadData() {
        guard let charaDomain = charalarmEnvironment.userDefaultsHandler.getCharaDomain()  else {
            fatalError("キャラクターのドメインの取得に失敗しました")
        }
        if let data = try? charalarmEnvironment.fileHandler.loadData(directoryName: charaDomain, fileName: "resource.json"),
           let resource: Resource = try? JSONDecoder().decode(Resource.self, from: data){
            print("ResourceVersion: \(resource.version)")
            // TODO: 選択中のキャラクターの最新リソースがある場合更新する
        } else {
            // データをロード
            if let fileUrl = Bundle.main.url(forResource: "resource", withExtension: "json", subdirectory: "Resource/com.charalarm.yui"),
               let data = try? Data(contentsOf: fileUrl),
               let resource: Resource = try? JSONDecoder().decode(Resource.self, from: data) {
                loadData(charaDomain: charaDomain, resource: resource)
            }
        }
    }
    
    func getIsDoneTutorial() -> Bool {
        // ユーザー名とパスワードを取得
        let anonymousUserName = keychainHandler.getAnonymousUserName()
        let anonymousUserPassword = keychainHandler.getAnonymousAuthToken()
        
        // 匿名ユーザー名、パスワードが登録されていればチュートリアル完了
        return anonymousUserName != nil && anonymousUserPassword != nil
    }
    
    func getAppVersion() -> String {
        guard let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            fatalError("アプリケーションのバージョンの取得に失敗しました。")
        }
        return appVersion
    }
    
    // データをロードする
    private func loadData(charaDomain:String, resource: Resource) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(resource)
            try charalarmEnvironment.fileHandler.saveFile(directoryName: charaDomain, fileName: "resource.json", data: data)
        } catch {
            return
        }
        
        for imageName in resource.resource.images {
            let fileInfo = imageName.split(separator: ".")
            do {
                let fileName: String = String(fileInfo[0])
                let type: String = String(fileInfo[1])
                guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: type, subdirectory: "Resource/com.charalarm.yui/image"),
                      let data = try? Data(contentsOf: fileUrl) else {
                    continue
                }
                try charalarmEnvironment.fileHandler.saveFile(directoryName: charaDomain, fileName: imageName, data: data)
            } catch {
                print("画像ファイルの書き込みに失敗")
            }
        }
        
        for voiceName in resource.resource.voices {
            let fileInfo = voiceName.split(separator: ".")
            do {
                let fileName: String = String(fileInfo[0])
                let type: String = String(fileInfo[1])
                guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: type, subdirectory: "Resource/com.charalarm.yui/voice"),
                      let data = try? Data(contentsOf: fileUrl) else {
                    continue
                }
                try charalarmEnvironment.fileHandler.saveFile(directoryName: charaDomain, fileName: voiceName, data: data)
            } catch {
                print("ボイスファイルの書き込みに失敗")
            }
        }
    }
}
