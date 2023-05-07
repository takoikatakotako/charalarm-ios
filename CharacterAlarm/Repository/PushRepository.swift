import Foundation

struct PushRepository {
    func addPushToken(userID: String, authToken: String, pushToken: PushTokenRequest) async throws {
        let path = "/push-token/ios/push/add"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Encodable = pushToken
        _ = try await APIClient<MessageResponse>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }

    func addVoipPushToken(userID: String, authToken: String, pushToken: PushTokenRequest) async throws {
        let path = "/push-token/ios/voip-push/add"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Encodable = pushToken
        _ = try await APIClient<MessageResponse>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
}
