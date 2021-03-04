import Foundation
import KeychainAccess

protocol KeychainHandlerProtcol {}

class KeychainHandler: KeychainHandlerProtcol {
    static func setAnonymousUserName(anonymousUserName: String) throws {
        try set(key: ANONYMOUS_USER_NAME, value: anonymousUserName)
    }
    
    static func setAnonymousUserPassword(anonymousUserPassword: String) throws {
        try set(key: ANONYMOUS_AUTH_TOKEN, value: anonymousUserPassword)
    }
    
    static func getAnonymousUserName() -> String? {
        return get(key: ANONYMOUS_USER_NAME)
    }
    
    static func getAnonymousAuthToken() -> String? {
        return get(key: ANONYMOUS_AUTH_TOKEN)
    }
    
    static private func set(key: String, value: String) throws {
        let keychain = Keychain()
        try keychain.set(value, key: key)
    }
    
    static private func get(key: String) -> String? {
        let keychain = Keychain()
        guard let value = try? keychain.get(key), value.isNotEmpty else {
            return nil
        }
        return value
    }
}
