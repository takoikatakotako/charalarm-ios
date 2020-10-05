import UIKit

class AlarmStore {
    static func fetchAnonymousAlarms(anonymousUserName: String, anonymousUserPassword: String, completion: @escaping (Result<[Alarm], Error>) -> Void) {
        let path = "/api/anonymous/alarm/list"
        let anonymousAuthBean = AnonymousAuthBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestBody: anonymousAuthBean)
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
    
    static func deleteAlarm(anonymousUserName: String, anonymousUserPassword: String, alarmId: Int, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "/api/anonymous/alarm/delete/\(alarmId)"
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
    
    static func editAlarm(anonymousUserName: String, anonymousUserPassword: String, alarm: Alarm, completion: @escaping (Result<String, Error>) -> Void) {
        guard let alarmId = alarm.alarmId else {
            return
        }
        let path = "/api/anonymous/alarm/edit/\(alarmId)"
        let anonymousAlarmBean = AnonymousAlarmBean(
            anonymousUserName: anonymousUserName,
            password: anonymousUserPassword,
            enable: alarm.enable,
            name: alarm.name,
            hour: alarm.hour,
            minute: alarm.minute,
            dayOfWeeks: alarm.dayOfWeeks)
        let urlRequest = APIRequest.createUrlRequest(path: path, httpMethod: .post, requestBody: anonymousAlarmBean)
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
}
