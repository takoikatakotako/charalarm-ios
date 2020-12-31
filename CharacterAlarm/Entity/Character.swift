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
        
    var charaThumbnailUrlString: String {
        return "\(String(describing: RESOURCE_ENDPOINT))/\(charaDomain)/image/thumbnail.png"
    }
}
