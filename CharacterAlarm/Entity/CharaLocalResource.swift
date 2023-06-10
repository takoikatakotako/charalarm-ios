import Foundation

struct CharaLocalResource: Encodable {
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


struct CharaLocalExpression: Encodable {
    let imageFileNames: [String]
    let voiceFileNames: [String]
    
    init(charaExpression: CharaExpression) {
        self.imageFileNames = charaExpression.images.map({ url in
            url.lastPathComponent
        })
        self.voiceFileNames = charaExpression.voices.map({ url in
            url.lastPathComponent
        })
    }
}


