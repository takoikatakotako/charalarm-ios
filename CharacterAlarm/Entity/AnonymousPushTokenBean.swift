import Foundation

struct AnonymousPushTokenBean: Encodable {
    let anonymousUserName: String
    let password: String
    let pushToken: String
}
