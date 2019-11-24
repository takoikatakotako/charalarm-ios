import FirebaseFirestore

struct  User {
    static let collectionName = "user"
    static let voipToken = "voip_token"
    static let characterId = "character_id"
    let id: String
    let createTime: Date
    let updateTime: Date
    let voipToken: String
    let characterId: String

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

        if let voipToken = document.get(User.voipToken) as? String {
            self.voipToken = voipToken
        } else {
            self.voipToken = "xxxx"
        }

        if let characterId = document.get("character_id") as? String {
            self.characterId = characterId
        } else {
            self.characterId = ""
        }
    }
}
