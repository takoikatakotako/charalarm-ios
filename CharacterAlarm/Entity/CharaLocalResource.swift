import Foundation

struct CharaLocalResource {
    let charaID: String
    var expressions: [String: CharaLocalExpression]
    
    init(chara: Chara) {
        self.charaID = chara.charaID

        var expressions: [String: CharaLocalExpression] = [:]
        chara.expressions.forEach { touple in
            expressions[touple.key] = CharaLocalExpression(charaExpression: touple.value)
        }
        self.expressions = expressions
    }
}


struct CharaLocalExpression: Hashable, Equatable {
    let imageFileNames: [String]
    let voiceFileNames: [String]
    
    init(charaExpression: CharaExpression) {
        self.imageFileNames = charaExpression.images
        self.voiceFileNames = charaExpression.voices
    }
}


