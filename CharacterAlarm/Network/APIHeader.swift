import Foundation

struct APIHeader {
    static let defaultHeader: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
    static func createAuthorizationRequestHeader(userName: String, token: String) -> [String: String] {
        guard let authorization = "\(userName):\(token)".data(using: .utf8)?.base64EncodedString() else {
            fatalError()
        }
        var requestHeader = Self.defaultHeader
        requestHeader["Authorization"] = "Basic \(authorization)"
        return requestHeader
    }
}
