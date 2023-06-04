import UIKit

struct Chara: Identifiable, Hashable, Equatable {
    init(charaResponse: CharaResponse) {
        charaID = charaResponse.charaID
        enable = charaResponse.enable
        name = charaResponse.name
        description = charaResponse.description
        profiles = charaResponse.profiles.map { CharaProfile(title: $0.title, name: $0.name, url: $0.url) }
        resources = charaResponse.resources.map { CharaResource(fileName: $0.fileURL) }
        expressions = charaResponse.expressions.mapValues { CharaExpression(images: $0.imageFileURLs, voices: $0.voiceFileURLs) }
        calls = charaResponse.calls.map { CharaCall(message: $0.message, voice: $0.voiceFileURL)}
    }
    
    var id: String {
        return charaID
    }
    
    
    var thumbnailUrlString: String {
        return "\(environmentVariable.resourceEndpoint)/\(charaID)/thumbnail.png"
    }
    
    var selfIntroductionUrlString: String {
        return "\(environmentVariable.resourceEndpoint)/\(charaID)/self-introduction.caf"
    }
    
    static func charaDomainToThmbnailUrlString(charaDomain: String) -> String {
        return "\(String(describing: environmentVariable.resourceEndpoint))/\(charaDomain)/thumbnail.png"
    }
    
    let charaID: String
    let enable: Bool
    let name: String
    let description: String
    let profiles: [CharaProfile]
    let resources: [CharaResource]
    let expressions: [String: CharaExpression]
    let calls: [CharaCall]
}

struct CharaProfile: Hashable, Equatable {
    let title: String
    let name: String
    let url: String
}

struct CharaResource: Hashable, Equatable {
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
