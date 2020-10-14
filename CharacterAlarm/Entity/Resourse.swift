import Foundation

struct ImageList: Decodable {
    let image: [String]
}

struct ImageAndVoiceList: Decodable {
    let image: [String]
    let voice: [String]
}

struct Resourse: Decodable {
    let version: Int
    let resource: ImageAndVoiceList
    let expression: [String: ImageAndVoiceList]
    let call: [String: [String]]
}
