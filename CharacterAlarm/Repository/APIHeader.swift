import Foundation

struct APIHeader {
    static let defaultHeader: [String: String] = ["Content-Type": "application/json"]

    static func createAuthorizationRequestHeader(userID: String, authToken: String) -> [String: String] {
        guard let authorization = "\(userID):\(authToken)".data(using: .utf8)?.base64EncodedString() else {
            fatalError()
        }
        var requestHeader = Self.defaultHeader
        requestHeader["Authorization"] = "Basic \(authorization)"
        return requestHeader
    }
}
