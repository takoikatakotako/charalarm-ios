import UIKit

struct AlarmRepository {
    func fetchAlarms(userID: String, authToken: String) async throws -> [AlarmResponse] {
        let path = "/alarm/list"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Request? = nil
        return try await APIClient<[AlarmResponse]>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
    
    func addAlarm(userID: String, authToken: String, requestBody: AlarmAddRequest) async throws {
        let path = "/alarm/add"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Request? = requestBody
        _ = try await APIClient<MessageResponse>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }

    func editAlarm(userID: String, authToken: String, requestBody: AlarmEditRequest) async throws {
        let path = "/alarm/edit"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Request? = requestBody
        _ = try await APIClient<MessageResponse>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
    
    func deleteAlarm(userID: String, authToken: String, requestBody: AlarmDeleteRequest) async throws {
        let path = "/alarm/delete"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader = APIHeader.createAuthorizationRequestHeader(userID: userID, authToken: authToken)
        let requestBody: Request? = requestBody
        _ = try await APIClient<MessageResponse>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
}
