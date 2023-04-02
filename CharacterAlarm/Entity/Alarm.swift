import UIKit

struct Alarm: Identifiable, Hashable {
    var id: UUID {
        return alarmID
    }
    var alarmID: UUID
    var type: AlarmType
    var enable: Bool
    var name: String
    var hour: Int
    var minute: Int
    var dayOfWeeks: [DayOfWeek]
    var charaID: String?
    var charaCallId: Int?
    
    var dayOfWeeksString: String {
        var text = ""
        text += dayOfWeeks.contains(.MON) ? "月 " : ""
        text += dayOfWeeks.contains(.THU) ? "火 " : ""
        text += dayOfWeeks.contains(.WED) ? "水 " : ""
        text += dayOfWeeks.contains(.THU) ? "木 " : ""
        text += dayOfWeeks.contains(.FRI) ? "金 " : ""
        text += dayOfWeeks.contains(.SAT) ? "土 " : ""
        text += dayOfWeeks.contains(.SUN) ? "日 " : ""
        return text
    }
}

//extension Alarm {
//    func toAlarmRequest(userID: UUID) -> AlarmRequest {
//        return AlarmRequest(
//            alarmID: alarmID,
//            userID: userID,
//            type: <#T##String#>,
//            enable: <#T##Bool#>,
//            name: <#T##String#>,
//            hour: <#T##Int#>,
//            minute: <#T##Int#>,
//            charaID: <#T##String#>,
//            charaName: <#T##String#>,
//            voiceFileName: <#T##String#>,
//            sunday: <#T##Bool#>,
//            monday: <#T##Bool#>,
//            tuesday: <#T##Bool#>,
//            wednesday: <#T##Bool#>,
//            thursday: <#T##Bool#>,
//            friday: <#T##Bool#>,
//            saturday: <#T##Bool#>
//        )
//    }
//}


enum AlarmType {
    case VOIP_NOTIFICATION
}
