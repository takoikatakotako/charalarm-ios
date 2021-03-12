import Foundation
import KeychainAccess

protocol KeychainHandlerProtcol {
    func setAnonymousUserName(anonymousUserName: String) throws
    func setAnonymousUserPassword(anonymousUserPassword: String) throws
    func getAnonymousUserName() -> String?
    func getAnonymousAuthToken() -> String?
}

class KeychainHandler: KeychainHandlerProtcol {
    func setAnonymousUserName(anonymousUserName: String) throws {
        try set(key: ANONYMOUS_USER_NAME, value: anonymousUserName)
    }
    
    func setAnonymousUserPassword(anonymousUserPassword: String) throws {
        try set(key: ANONYMOUS_AUTH_TOKEN, value: anonymousUserPassword)
    }
    
    func getAnonymousUserName() -> String? {
        return get(key: ANONYMOUS_USER_NAME)
    }
    
    func getAnonymousAuthToken() -> String? {
        return get(key: ANONYMOUS_AUTH_TOKEN)
    }
    
    private func set(key: String, value: String) throws {
        let keychain = Keychain()
        try keychain.set(value, key: key)
    }
    
    private func get(key: String) -> String? {
        let keychain = Keychain()
        guard let value = try? keychain.get(key), value.isNotEmpty else {
            return nil
        }
        return value
    }
}
