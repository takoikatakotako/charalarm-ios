import Foundation

struct ImageList: Codable {
    let images: [String]
}

struct ImageAndVoiceList: Codable {
    let images: [String]
    let voices: [String]
}

struct Resource: Codable {
    let version: Int
    let resource: ImageAndVoiceList
    let expression: [String: ImageAndVoiceList]
    let call: [String: [String]]
}
