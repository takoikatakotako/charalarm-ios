import UIKit

struct Character: Identifiable, Hashable, Equatable {
    init(charaResponse: CharaResponse) {
        charaID = charaResponse.charaID
        enable = charaResponse.enable
        name = charaResponse.name
        description = charaResponse.description
        profiles = charaResponse.profiles.map { CharaProfile(title: $0.title, name: $0.name, url: $0.url) }
        resources = CharaResource(images: charaResponse.resources.images, voices: charaResponse.resources.voices)
        expressions = charaResponse.expressions.mapValues { CharaExpression(images: $0.images, voices: $0.voices) }
        calls = CharaCall(voices: charaResponse.calls.voices)
    }
    
    var id: String {
        return charaID
    }
    
    // Deprecated
    var charaDomain: String {
        return charaID
    }
    
    var charaThumbnailUrlString: String {
        return Self.charaDomainToThmbnailUrlString(charaDomain: charaDomain)
    }
    
    static func charaDomainToThmbnailUrlString(charaDomain: String) -> String {
        return "\(String(describing: RESOURCE_ENDPOINT))/\(charaDomain)/image/thumbnail.png"
    }
    
    let charaID: String
    let enable: Bool
    let name: String
    let description: String
    let profiles: [CharaProfile]
    let resources: CharaResource
    let expressions: [String: CharaExpression]
    let calls: CharaCall
    
    //    let charaId: Int
    //    let charaDomain: String
    //    let name: String
    //    let description: String
    //    let illustrationName: String
    //    let illustrationUrl: String
    //    let voiceName: String
    //    let voiceUrl: String
    //    let additionalProfileBeans: [CharaAdditionalProfileBean]
    //    let charaCallResponseEntities: [CharaCallResponseEntity]
    //    var charaThumbnailUrlString: String {
    //        return Self.charaDomainToThmbnailUrlString(charaDomain: charaDomain)
    //    }
    //
    //    static func charaDomainToThmbnailUrlString(charaDomain: String) -> String {
    //        return "\(String(describing: RESOURCE_ENDPOINT))/\(charaDomain)/image/thumbnail.png"
    //    }
}

//


struct CharaProfile: Hashable, Equatable {
    let title: String
    let name: String
    let url: String
}

struct CharaResource: Hashable, Equatable {
    let images: [String]
    let voices: [String]
}

struct CharaExpression: Hashable, Equatable {
    let images: [String]
    let voices: [String]
}

struct CharaCall: Hashable, Equatable {
    let voices: [String]
}

