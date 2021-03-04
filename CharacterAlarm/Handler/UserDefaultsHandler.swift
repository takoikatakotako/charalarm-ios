import UIKit
import Foundation

protocol UserDefaultsHandlerProtocol {
    func registerDefaults(defaults: [String: String])
    func getCharaDomain() -> String?
    func setCharaDomain(charaDomain: String)
    func getCharaName() -> String?
    func setCharaName(charaName: String)
}

class UserDefaultsHandler: UserDefaultsHandlerProtocol {
    // UserDefaults の初期値を設定する
    func registerDefaults(defaults: [String: String]) {
        UserDefaults.standard.register(defaults: defaults)
    }
    
    func getCharaDomain() -> String? {
        guard let charaDomain = UserDefaults.standard.string(forKey: CHARA_DOMAIN) else {
            return nil
        }
        return charaDomain
    }
    
    func setCharaDomain(charaDomain: String) {
        UserDefaults.standard.set(charaDomain, forKey: CHARA_DOMAIN)
    }
    
    func getCharaName() -> String? {
        guard let charaName = UserDefaults.standard.string(forKey: CHARA_NAME) else {
            return nil
        }
        return charaName
    }
    
    func setCharaName(charaName: String) {
        UserDefaults.standard.set(charaName, forKey: CHARA_NAME)
    }
}
