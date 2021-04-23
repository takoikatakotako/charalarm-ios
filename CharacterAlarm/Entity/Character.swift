import UIKit

struct Character: Identifiable, Decodable, Hashable {
    var id: Int {
        return charaId
    }
    let charaId: Int
    let charaDomain: String
    let name: String
    let description: String
    let illustrationName: String
    let illustrationUrl: String
    let voiceName: String
    let voiceUrl: String
    let additionalProfileBeans: [CharaAdditionalProfileBean]
    let charaCallResponseEntities: [CharaCallResponseEntity]
    var charaThumbnailUrlString: String {
        return Self.charaDomainToThmbnailUrlString(charaDomain: charaDomain)
    }
    
    static func charaDomainToThmbnailUrlString(charaDomain: String) -> String {
        return "\(String(describing: RESOURCE_ENDPOINT))/\(charaDomain)/image/thumbnail.png"
    }
}

extension Character {
    static func mock() -> Character {
        return Character(charaId: 1, charaDomain: "yui.inoue", name: "", description: "", illustrationName: "", illustrationUrl: "", voiceName: "", voiceUrl: "", additionalProfileBeans: [], charaCallResponseEntities: [])
    }
}

