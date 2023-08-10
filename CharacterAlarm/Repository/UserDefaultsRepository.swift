import Foundation

protocol UserDefaultsRepositoryProtocol {
    func registerDefaults()
    func getCharaID() -> String?
    func setCharaDomain(charaDomain: String)
    func setDefaultCharaDomain()
    func getCharaName() -> String?
    func setCharaName(charaName: String)
    func setDefaultCharaName()
}

struct UserDefaultsRepository: UserDefaultsRepositoryProtocol {
    // Keys
    private let CHARA_DOMAIN = "CHARA_DOMAIN"
    private let CHARA_NAME = "CHARA_NAME"
    
    // Defaults
    private let DEFAULT_CHARA_DOMAIN = "com.charalarm.yui"
    private let DEFAULT_CHARA_NAME = "井上結衣"
    
    // UserDefaults の初期値を設定する
    func registerDefaults() {
        let defaults =  [CHARA_DOMAIN : DEFAULT_CHARA_DOMAIN, CHARA_NAME: DEFAULT_CHARA_NAME]
        UserDefaults.standard.register(defaults: defaults)
    }
    
    func getCharaID() -> String? {
        guard let charaDomain = UserDefaults.standard.string(forKey: CHARA_DOMAIN) else {
            return nil
        }
        return charaDomain
    }
    
    func setCharaDomain(charaDomain: String) {
        UserDefaults.standard.set(charaDomain, forKey: CHARA_DOMAIN)
    }
    
    func setDefaultCharaDomain() {
        UserDefaults.standard.set(CHARA_DOMAIN, forKey: DEFAULT_CHARA_DOMAIN)
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
    
    func setDefaultCharaName() {
        UserDefaults.standard.set(CHARA_NAME, forKey: DEFAULT_CHARA_DOMAIN)
    }
}
