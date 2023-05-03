import Foundation

struct UserInfoResponse: Response {
    let userID: UUID
    let authToken: String
    let iosVoIPPushTokens: UserInfoPushTokenResponse
    let iosPushTokens: UserInfoPushTokenResponse
}

struct UserInfoPushTokenResponse: Response {
    let token: String
    let snsEndpointArn: String
}
