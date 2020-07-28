import UIKit

struct Character: Identifiable, Decodable {
    let id = UUID()
    let charaId: Int
    let charaDomain: String
    let name: String
    let description: String
    let circleName: String
    let circleUrl: String
    let voiceName: String
    let voiceUrl: String
}


//struct  Character: Identifiable {
//    static let collectionName = "character"
//    static let id = "id"
//    static let createTime = "create_time"
//    static let updateTime = "update_time"
//    static let name = "name"
//
//    let id: String
//    let createTime: Date
//    let updateTime: Date
//    let name: String
//
//    init(id: String, document: DocumentSnapshot) {
//        self.id = id
//
//        if let createTime = document.get(Character.createTime) as? Timestamp {
//            self.createTime = createTime.dateValue()
//        } else {
//            createTime = Date()
//        }
//
//        if let updateTime = document.get(Character.updateTime) as? Timestamp {
//            self.updateTime = updateTime.dateValue()
//        } else {
//            updateTime = Date()
//        }
//
//        if let name = document.get(Character.name) as? String {
//            self.name = name
//        } else {
//            self.name = ""
//        }
//    }
//}
