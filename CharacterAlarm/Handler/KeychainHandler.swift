import Foundation
import KeychainAccess

class KeychainHandler {
    static func setAnonymousUserName(anonymousUserName: String) throws {
        try set(key: ANONYMOUS_USER_NAME, value: anonymousUserName)
    }
    
    static func setAnonymousUserPassword(anonymousUserPassword: String) throws {
        try set(key: ANONYMOUS_USER_PASSWORD, value: anonymousUserPassword)
    }
    
    static func getAnonymousUserName() -> String? {
        return get(key: ANONYMOUS_USER_NAME)
    }
    
    static func getAnonymousUserPassword() -> String? {
        return get(key: ANONYMOUS_USER_PASSWORD)
    }
    
    static private func set(key: String, value: String) throws {
        let keychain = Keychain()
        try keychain.set(value, key: key)
    }
    
    static private func get(key: String) -> String? {
        let keychain = Keychain()
        return try? keychain.get(key)
    }
}
