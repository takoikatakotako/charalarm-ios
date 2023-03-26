import Foundation

struct CharaResponse: Decodable {
    let charaID: String
    let enable: Bool
    let name: String
    let description: String
    let profiles: [CharaProfileResponse]
    let resources: [CharaResourceResponse]
    let expressions: [String: CharaExpressionResponse]
    let calls: [CharaCallResponse]
}

struct CharaProfileResponse: Decodable {
    let title: String
    let name: String
    let url: String
}

struct CharaResourceResponse: Decodable {
    let directoryName: String
    let fileName: String
}

struct CharaExpressionResponse: Decodable {
    let images: [String]
    let voices: [String]
}

struct CharaCallResponse: Decodable {
    let message: String
    let voice: String
}
