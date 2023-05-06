import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct APIRequest {
    static func createUrlRequest(baseUrl: String = API_ENDPOINT, path: String, httpMethod: HttpMethod = .get, requestHeader: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]) -> URLRequest {
        let url = URL(string: baseUrl + path)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = requestHeader
        return request
    }
    
    static func createUrlRequest<RequestBody: Encodable>(baseUrl: String = API_ENDPOINT, path: String, httpMethod: HttpMethod = .get, requestHeader: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"], requestBody: RequestBody) -> URLRequest {
        let url = URL(string: API_ENDPOINT + path)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = requestHeader
        if let httpBody = try? JSONEncoder().encode(requestBody) {
            request.httpBody = httpBody
        }
        return request
    }
}