import UIKit

struct AlarmResponse: Identifiable, Decodable, Hashable, Encodable {
    var id: UUID {
       return alarmID
    }
    var alarmID: UUID
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
