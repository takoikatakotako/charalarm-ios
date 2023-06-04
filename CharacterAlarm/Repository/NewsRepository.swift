import Foundation

struct NewsRepository {
    func fetchNews() async throws -> [News] {
        let path = "/api/news/list"
        let url = URL(string: environmentVariable.apiEndpoint + path)!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = nil
        return try await APIClient<[News]>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
}
