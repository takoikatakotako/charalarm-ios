import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct APIRequest<RequestBody: Encodable> {
    let path: String
    let httpMethod: HttpMethod
    let requestHeader: [String: String]
    let requestBody: RequestBody?
    
    init(path: String, httpMethod: HttpMethod = .get, requestHeader: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"], requestBody: RequestBody?) {
        self.path = path
        self.httpMethod = httpMethod
        self.requestHeader = requestHeader
        self.requestBody = requestBody
    }
    
    func toURLRequest() -> URLRequest {
        let url = URL(string: BASE_URL + path)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = requestHeader
        if let requestBody = requestBody, let httpBody = try? JSONEncoder().encode(requestBody) {
            request.httpBody = httpBody
        }
        return request
    }
    
//    static func toUrlRequest(path: String, httpMethod: HttpMethod = .get, requestHeader: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]) -> URLRequest {
//        let url = URL(string: BASE_URL + path)!
//        var request = URLRequest(url: url)
//        request.httpMethod = httpMethod.rawValue
//        request.allHTTPHeaderFields = requestHeader
//        return request
//    }
//
//    static func toUrlRequest<RequestBody: Encodable>(path: String, httpMethod: HttpMethod = .get, requestHeader: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"], requestBody: RequestBody) -> URLRequest {
//        let url = URL(string: BASE_URL + path)!
//        var request = URLRequest(url: url)
//        request.httpMethod = httpMethod.rawValue
//        request.allHTTPHeaderFields = requestHeader
//        if let httpBody = try? JSONEncoder().encode(requestBody) {
//            request.httpBody = httpBody
//        }
//        return request
//    }
}


struct APIRequest2 {
    static func toUrlRequest(path: String, httpMethod: HttpMethod = .get, requestHeader: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]) -> URLRequest {
        let url = URL(string: BASE_URL + path)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = requestHeader
        return request
    }
    
    static func toUrlRequest<RequestBody: Encodable>(path: String, httpMethod: HttpMethod = .get, requestHeader: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"], requestBody: RequestBody) -> URLRequest {
        let url = URL(string: BASE_URL + path)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = requestHeader
        if let httpBody = try? JSONEncoder().encode(requestBody) {
            request.httpBody = httpBody
        }
        return request
    }
}
