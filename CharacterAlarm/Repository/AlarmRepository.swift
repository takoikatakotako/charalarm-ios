import UIKit

class AlarmRepository {
    func fetchAlarms(userID: String, authToken: String) async throws -> [AlarmResponse] {
        let path = "/alarm/list"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Encodable? = nil
        return try await APIClient<[AlarmResponse]>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
    
    func addAlarm(userID: String, authToken: String, requestBody: AlarmAddRequest) async throws {
        let path = "/alarm/add"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Encodable? = requestBody
        _ = try await APIClient<MessageResponse>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }

    func editAlarm(userID: String, authToken: String, requestBody: Alarm) async throws {
        let path = "/api/alarm/edit"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Encodable? = nil
        _ = try await APIClient<[MessageResponse]>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
    
    func deleteAlarm(userID: String, authToken: String, alarmId: Int) async throws {
        let path = "/api/alarm/delete"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Encodable? = alarmId
        _ = try await APIClient<[MessageResponse]>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
}
