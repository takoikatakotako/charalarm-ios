import UIKit

class AnonymousUserStore {
    static func signup(anonymousUserName: String, anonymousUserPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/anonymous/auth/signup"
        let anonymousAuthBean = AnonymousAuthBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestBody: anonymousAuthBean)
        let apiClient = APIClient<JsonResponseBean<String>>()
        apiClient.request(urlRequest: urlRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    completion(.success(response.data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func withdraw(anonymousUserName: String, anonymousUserPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/anonymous/auth/withdraw"
        let anonymousAuthBean = AnonymousAuthBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestBody: anonymousAuthBean)
        let apiClient = APIClient<JsonResponseBean<String>>()
        apiClient.request(urlRequest: urlRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    completion(.success(response.data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
