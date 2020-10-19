import Foundation

struct ImageList: Codable {
    let image: [String]
}

struct ImageAndVoiceList: Codable {
    let image: [String]
    let voice: [String]
}

struct Resource: Codable {
    let version: Int
    let resource: ImageAndVoiceList
    let expression: [String: ImageAndVoiceList]
    let call: [String: [String]]
}
