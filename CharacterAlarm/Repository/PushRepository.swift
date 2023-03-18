import Foundation

class PushRepository {
    func addPushToken(anonymousUserName: String, anonymousUserPassword: String, pushToken: PushTokenRequest, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/push-token/ios/push/add"
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: anonymousUserName, authToken: anonymousUserPassword)
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
    
    func addPushToken(anonymousUserName: String, anonymousUserPassword: String, pushToken: PushTokenRequest) async throws -> String {
        let path = "/api/push-token/ios/push/add"
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: anonymousUserName, authToken: anonymousUserPassword)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestHeader: requestHeader, requestBody: pushToken)
        let apiClient = APIClient<JsonResponseBean<String>>()
        let response = try await apiClient.request(urlRequest: urlRequest)
        return response.data
    }
    
    func addVoipPushToken(anonymousUserName: String, anonymousUserPassword: String, pushToken: PushTokenRequest, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/push-token/ios/voip-push/add"
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: anonymousUserName, authToken: anonymousUserPassword)
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
    
    func addVoipPushToken(anonymousUserName: String, anonymousUserPassword: String, pushToken: PushTokenRequest) async throws -> String {
        let path = "/api/push-token/ios/voip-push/add"
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: anonymousUserName, authToken: anonymousUserPassword)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestHeader: requestHeader, requestBody: pushToken)
        let apiClient = APIClient<JsonResponseBean<String>>()
        let response = try await apiClient.request(urlRequest: urlRequest)
        return response.data
//        apiClient.request(urlRequest: urlRequest) { result in
//            switch result {
//            case let .success(response):
//                completion(.success(response.data))
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
    }
}
