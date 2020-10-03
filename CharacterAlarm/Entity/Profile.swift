import UIKit

struct Profile: Identifiable {
    static let collectionName = "profile"
    static let id = "id"
    static let characterId = "character_id"
    static let createTime = "create_time"
    static let updateTime = "update_time"
    static let name = "name"
    static let description = "description"
    static let circleName = "circle_name"
    static let circleUrl = "circle_url"
    static let voiceName = "voice_name"

    let id: String
    let characterId: String
    let createTime: Date
    let updateTime: Date
    let name: String
    let description: String

    var circleName: String = ""
    var circleUrl: String = ""
    var circleUrlType: String = "twitter"

    var illustName: String = ""
    var illustUrl: String = ""
    var illustUrlType: String = "twitter"

    var voiceName: String = ""
    var voiceUrl: String = ""
    var voiceUrlType: String = "twitter"

    init() {
        id = "sdfsdf"
        characterId = ""
        createTime = Date()
        updateTime = Date()
        name = "XXXXX"
        description = "sdfsdfsdfs"
    }
}
