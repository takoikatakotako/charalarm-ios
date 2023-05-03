import UIKit

struct UserInfo: Identifiable, Hashable {
    var id: UUID {
        return userID
    }
    let userID: UUID
    let authToken: String
    let iosVoIPPushTokens: UserInfoPushToken
    let iosPushTokens: UserInfoPushToken
}

struct UserInfoPushToken: Hashable {
    let token: String
    let snsEndpointArn: String
}
