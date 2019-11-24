import UIKit
import FirebaseFirestore

struct Profile {
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

    init(id: String, document: DocumentSnapshot) {
        self.id = id

        if let createTime = document.get(Profile.createTime) as? Timestamp {
            self.createTime = createTime.dateValue()
        } else {
            createTime = Date()
        }

        if let updateTime = document.get(Profile.updateTime) as? Timestamp {
            self.updateTime = updateTime.dateValue()
        } else {
            updateTime = Date()
        }

        if let name = document.get(Profile.name) as? String {
            self.name = name
        } else {
            self.name = ""
        }

        if let description = document.get(Profile.description) as? String {
            self.description = description
        } else {
            self.description = ""
        }

        if let circleName = document.get(Profile.circleName) as? String {
            self.circleName = circleName
        }

        if let circleUrl = document.get(Profile.circleName) as? String {
            self.circleUrl = circleUrl
        }

        if let voiceName = document.get(Profile.voiceName) as? String {
            self.voiceName = voiceName
        }
    }
}
