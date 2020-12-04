import Foundation

struct PushTokenRequest: Encodable, Hashable {
    let osType: String
    let pushTokenType: String
    let pushToken: String
}
