import UIKit
import Foundation

class UserDefaultsHandler {
    // UserDefaults の初期値を設定する
    static func registerDefaults(defaults: [String: String]) {
        UserDefaults.standard.register(defaults: defaults)
    }
    
    static func getCharacterDomain() -> String? {
        guard let characterDomain = UserDefaults.standard.string(forKey: CHARACTER_DOMAIN) else {
            return nil
        }
        return characterDomain
    }
    
    static func setCharaDomain(charaDomain: String) {
        UserDefaults.standard.set(charaDomain, forKey: CHARACTER_DOMAIN)
    }
}
