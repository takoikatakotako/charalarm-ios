import UIKit

struct Chara: Identifiable, Hashable, Equatable {
    init(charaResponse: CharaResponse) {
        charaID = charaResponse.charaID
        enable = charaResponse.enable
        name = charaResponse.name
        description = charaResponse.description
        profiles = charaResponse.profiles.map { CharaProfile(title: $0.title, name: $0.name, url: $0.url) }
        resources = charaResponse.resources.map { CharaResource(directoryPath: $0.directoryName, fileName: $0.fileName) }
        expressions = charaResponse.expressions.mapValues { CharaExpression(images: $0.images, voices: $0.voices) }
        calls = charaResponse.calls.map { CharaCall(message: $0.message, voice: $0.voice)}
    }
    
    var id: String {
        return charaID
    }
    
    var charaThumbnailUrlString: String {
        return Self.charaDomainToThmbnailUrlString(charaDomain: charaID)
    }
    
    static func charaDomainToThmbnailUrlString(charaDomain: String) -> String {
        return "\(String(describing: RESOURCE_ENDPOINT))/\(charaDomain)/image/thumbnail.png"
    }
    
    let charaID: String
    let enable: Bool
    let name: String
    let description: String
    let profiles: [CharaProfile]
    let resources: [CharaResource]
    let expressions: [String: CharaExpression]
    let calls: [CharaCall]
    
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


struct CharaProfile: Hashable, Equatable {
    let title: String
    let name: String
    let url: String
}

struct CharaResource: Hashable, Equatable {
    let directoryPath: String
    let fileName: String
}

struct CharaExpression: Hashable, Equatable {
    let images: [String]
    let voices: [String]
}

struct CharaCall: Hashable, Equatable {
    let message: String
    let voice: String
}

