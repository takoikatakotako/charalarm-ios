import Foundation

class NewsRepository {
    func fetchNews() async throws -> [News] {
        let path = "/api/news/list"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = nil
        return try await APIClient<[News]>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
}
