import UIKit

class UserRepository {
    func info(userID: String, authToken: String) async throws -> UserInfo {
        let path = "/user/info"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Encodable? = nil
        let userInfoResponse = try await APIClient<UserInfoResponse>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
        
        // 変換
        let iOSPlatformInfo = UserInfoIOSPlatformInfo (
            pushToken: userInfoResponse.iOSPlatformInfo.pushToken,
            pushTokenSNSEndpoint: userInfoResponse.iOSPlatformInfo.pushTokenSNSEndpoint,
            voIPPushToken: userInfoResponse.iOSPlatformInfo.voIPPushToken,
            voIPPushTokenSNSEndpoint: userInfoResponse.iOSPlatformInfo.voIPPushTokenSNSEndpoint
        )
        return UserInfo(
            userID: userInfoResponse.userID,
            authToken: userInfoResponse.authToken,
            platform: userInfoResponse.platform,
            iOSPlatformInfo: iOSPlatformInfo)
    }

    func signup(request: UserSignUpRequest) async throws {
        let path = "/user/signup"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = request
        _ = try await APIClient<MessageResponse>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
    
    func withdraw(userID: String, authToken: String) async throws {
        let path = "/user/withdraw"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Encodable? = nil
        _ = try await APIClient<MessageResponse>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
}
