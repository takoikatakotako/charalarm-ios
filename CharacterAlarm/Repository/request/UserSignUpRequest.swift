import Foundation

struct UserSignUpRequest: Encodable {
    let userID: String
    let authToken: String
}
