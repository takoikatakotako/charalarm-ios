import UIKit

class UserDefaultsStore {
    static func getCharacterDomain() -> String {
        guard let characterDomain = UserDefaults.standard.string(forKey: CHARACTER_DOMAIN) else {
            fatalError("CharacterDomainが取得できませんでした")
        }
        return characterDomain
    }
    
    static func setCharaDomain(charaDomain: String) {
        UserDefaults.standard.set(charaDomain, forKey: CHARACTER_DOMAIN)
    }
    
    static func getAnonymousUserName() -> String? {
        return UserDefaults.standard.string(forKey: ANONYMOUS_USER_NAME)
    }
    
    static func getAnonymousUserPassword() -> String? {
        return UserDefaults.standard.string(forKey: ANONYMOUS_USER_PASSWORD)
    }
}
