import SwiftUI

struct JsonResponseBean<T: Decodable>: Decodable  {
    let data: T
    let errors: ExceptionErrors
}


struct ExceptionErrors: Decodable {
    let UserNotFoundException: String?
}
