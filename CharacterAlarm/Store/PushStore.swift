import Foundation

class PushStore {
    static func addPushToken(anonymousUserName: String, anonymousUserPassword: String, pushToken: PushTokenRequest, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/push-token/ios/push/add"
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userName: anonymousUserName, token: anonymousUserPassword)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestHeader: requestHeader, requestBody: pushToken)
        let apiClient = APIClient<JsonResponseBean<String>>()
        apiClient.request(urlRequest: urlRequest) { result in
            switch result {
            case let .success(response):
                completion(.success(response.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func addVoipPushToken(anonymousUserName: String, anonymousUserPassword: String, pushToken: PushTokenRequest, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/push-token/ios/voip-push/add"
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userName: anonymousUserName, token: anonymousUserPassword)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestHeader: requestHeader, requestBody: pushToken)
        let apiClient = APIClient<JsonResponseBean<String>>()
        apiClient.request(urlRequest: urlRequest) { result in
            switch result {
            case let .success(response):
                completion(.success(response.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }    
    }
}
