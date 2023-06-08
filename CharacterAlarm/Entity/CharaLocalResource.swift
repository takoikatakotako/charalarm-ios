import Foundation

struct CharaLocalResource {
    let charaID: String
    let expressions: [String: CharaLocalExpression]
}


struct CharaLocalExpression: Hashable, Equatable {
    let imageFileNames: [String]
    let voiceFileNames: [String]
}


