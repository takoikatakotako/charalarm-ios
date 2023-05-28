import UIKit

struct OtherRepository {
    func fetchMaintenance() async throws -> Bool {
        let path = "/maintenance"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader = APIHeader.defaultHeader
        let requestBody: Request? = nil
        let response = try await APIClient<MaintenanceResponse>().request2(url: url, httpMethod: .get, requestHeader: requestHeader, requestBody: requestBody)
        return response.maintenance
    }
    
    func fetchRequireVersion() async throws -> String {
        let path = "/require"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader = APIHeader.defaultHeader
        let requestBody: Request? = nil
        let response = try await APIClient<RequireVersionResponse>().request2(url: url, httpMethod: .get, requestHeader: requestHeader, requestBody: requestBody)
        return response.iosVersion
    }
}
