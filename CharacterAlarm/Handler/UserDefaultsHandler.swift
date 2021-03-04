import UIKit
import Foundation

protocol UserDefaultsHandlerProtocol {}

class UserDefaultsHandler: UserDefaultsHandlerProtocol {
    // UserDefaults の初期値を設定する
    static func registerDefaults(defaults: [String: String]) {
        UserDefaults.standard.register(defaults: defaults)
    }
    
    static func getCharaDomain() -> String? {
        guard let charaDomain = UserDefaults.standard.string(forKey: CHARA_DOMAIN) else {
            return nil
        }
        return charaDomain
    }
    
    static func setCharaDomain(charaDomain: String) {
        UserDefaults.standard.set(charaDomain, forKey: CHARA_DOMAIN)
    }
    
    static func getCharaName() -> String? {
        guard let charaName = UserDefaults.standard.string(forKey: CHARA_NAME) else {
            return nil
        }
        return charaName
    }
    
    static func setCharaName(charaName: String) {
        UserDefaults.standard.set(charaName, forKey: CHARA_NAME)
    }
}
