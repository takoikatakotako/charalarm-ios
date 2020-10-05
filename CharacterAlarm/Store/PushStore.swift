import Foundation

class PushStore {
    static func addPushToken(anonymousUserName: String, anonymousUserPassword: String, pushToken: String, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/anonymous/token/ios/push/add"
        let anonymousPushTokenBean = AnonymousPushTokenBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword, pushToken: pushToken)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestBody: anonymousPushTokenBean)
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
    
    static func addVoipPushToken(anonymousUserName: String, anonymousUserPassword: String, pushToken: String, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/anonymous/token/ios/voip-push/add"
        let anonymousPushTokenBean = AnonymousPushTokenBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword, pushToken: pushToken)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestBody: anonymousPushTokenBean)
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
