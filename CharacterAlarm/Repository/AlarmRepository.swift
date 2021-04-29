import UIKit

class AlarmRepository {
    func fetchAnonymousAlarms(anonymousUserName: String, anonymousUserPassword: String, completion: @escaping (Result<[Alarm], Error>) -> Void) {
        let path = "/api/alarm/list"
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userName: anonymousUserName, token: anonymousUserPassword)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestHeader: requestHeader)
        let apiClient = APIClient<JsonResponseBean<[Alarm]>>()
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
    
    func addAlarm(anonymousUserName: String, anonymousUserPassword: String, alarm: Alarm, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/alarm/add"
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userName: anonymousUserName, token: anonymousUserPassword)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestHeader: requestHeader, requestBody: alarm)
        let apiClient = APIClient<JsonResponseBean<String>>()
        apiClient.request(urlRequest: urlRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    return completion(.success(response.data))
                case let .failure(error):
                    return completion(.failure(error))
                }
            }
        }
    }

    func editAlarm(anonymousUserName: String, anonymousUserPassword: String, alarm: Alarm, completion: @escaping (Result<String, Error>) -> Void) {
        guard let alarmId = alarm.alarmId else {
            return
        }
        let path = "/api/alarm/edit/\(alarmId)"
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userName: anonymousUserName, token: anonymousUserPassword)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestHeader: requestHeader, requestBody: alarm)
        let apiClient = APIClient<JsonResponseBean<String>>()
        apiClient.request(urlRequest: urlRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    return completion(.success(response.data))
                case let .failure(error):
                    return completion(.failure(error))
                }
            }
        }
    }
    
    func deleteAlarm(anonymousUserName: String, anonymousUserPassword: String, alarmId: Int, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/alarm/delete/\(alarmId)"
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
