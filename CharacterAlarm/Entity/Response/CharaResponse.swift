import Foundation

struct CharaResponse: Response {
    let charaID: String
    let enable: Bool
    let name: String
    let description: String
    let profiles: [CharaProfileResponse]
    let resources: [CharaResourceResponse]
    let expressions: [String: CharaExpressionResponse]
    let calls: [CharaCallResponse]
}

struct CharaProfileResponse: Response {
    let title: String
    let name: String
    let url: String
}

struct CharaResourceResponse: Response {
    let directoryName: String
    let fileName: String
}

struct CharaExpressionResponse: Response {
    let images: [String]
    let voices: [String]
}

struct CharaCallResponse: Response {
    let message: String
    let voice: String
}
