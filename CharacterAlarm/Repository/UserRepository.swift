import UIKit

class UserRepository {
    func signup(userID: String, authToken: String) async throws {
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable = UserSignUpRequest(userID: userID, authToken: authToken)
        
        let path = "/user/signup"
        let url = URL(string: API_ENDPOINT + path)!
        _ = try await APIClient<MessageResponse>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
    
    func withdraw(userID: String, authToken: String) async throws {
        let requestHeader: [String: String] = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Encodable? = nil

        let path = "/user/withdraw"
        let url = URL(string: API_ENDPOINT + path)!
        _ = try await APIClient<MessageResponse>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
}
