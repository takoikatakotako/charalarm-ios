import UIKit

class UserRepository {
//    func signup(anonymousUserName: String, anonymousUserPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
//        let path = "/api/auth/anonymous/signup"
//        let requestHeader = APIHeader.createAuthorizationRequestHeader(userName: anonymousUserName, token: anonymousUserPassword)
//        let urlRequest: URLRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestHeader: requestHeader)
//        let apiClient = APIClient<JsonResponseBean<String>>()
//        apiClient.request(urlRequest: urlRequest) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case let .success(response):
//                    completion(.success(response.data))
//                case let .failure(error):
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
    
    func signup(anonymousUserName: String, anonymousUserPassword: String) async throws -> String {
        let path = "/api/auth/anonymous/signup"
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userName: anonymousUserName, token: anonymousUserPassword)
        let urlRequest: URLRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestHeader: requestHeader)
        let apiClient = APIClient<JsonResponseBean<String>>()
        let response = try await apiClient.request(urlRequest: urlRequest)
        return response.data
    }
    
    func withdraw(anonymousUserName: String, anonymousUserPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/auth/anonymous/withdraw"
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userName: anonymousUserName, token: anonymousUserPassword)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestHeader: requestHeader)
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
