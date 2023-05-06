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
    let fileURL: String
}

struct CharaExpressionResponse: Response {
    let imageFileURLs: [String]
    let voiceFileURLs: [String]
}

struct CharaCallResponse: Response {
    let message: String
    let voiceFileURL: String
}
