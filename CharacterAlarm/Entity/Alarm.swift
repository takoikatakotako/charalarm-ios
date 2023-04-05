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
    var timeDifference: Decimal
    var charaName: String
    var dayOfWeeks: [DayOfWeek]
    var charaID: String?
    var charaCallId: Int?
    var voiceFileName: String?
    var sunday: Bool
    var monday: Bool
    var tuesday: Bool
    var wednesday: Bool
    var thursday: Bool
    var friday: Bool
    var saturday: Bool
    
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

extension Alarm {
    func toAlarmRequest(userID: UUID) -> AlarmRequest {
        return AlarmRequest(
            alarmID: alarmID,
            userID: userID,
            type: type.rawValue,
            enable: enable,
            name: name,
            hour: hour,
            minute: minute,
            timeDifference: timeDifference,
            charaID: charaID ?? "",
            charaName: charaName,
            voiceFileName: voiceFileName ?? "",
            sunday: sunday,
            monday: monday,
            tuesday: tuesday,
            wednesday: wednesday,
            thursday: thursday,
            friday: friday,
            saturday: saturday
        )
    }
}

enum AlarmType: String {
    case VOIP_NOTIFICATION = "VOIP_NOTIFICATION"
}
