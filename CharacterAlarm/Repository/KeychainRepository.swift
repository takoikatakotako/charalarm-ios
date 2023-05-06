import Foundation
import KeychainAccess

struct KeychainRepository {
    func setUserID(userID: UUID) throws {
        try set(key: ANONYMOUS_USER_NAME, value: userID.uuidString)
        try set(key: USER_ID, value: userID.uuidString)
    }
    
    func setAuthToken(authToken: UUID) throws {
        try set(key: ANONYMOUS_AUTH_TOKEN, value: authToken.uuidString)
        try set(key: AUTH_TOKEN, value: authToken.uuidString)
    }
    
    func getUserID() -> String? {
        if let userID = get(key: USER_ID) {
            return userID
        }
        return get(key: ANONYMOUS_USER_NAME)
    }
    
    func getAuthToken() -> String? {
        if let authToken = get(key: AUTH_TOKEN) {
            return authToken
        }
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
