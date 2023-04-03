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
    
    var sunday: Bool
    var monday: Bool
    var tuesday: Bool
    var wednesday: Bool
    var thursday: Bool
    var friday: Bool
    var saturday: Bool
}

extension AlarmResponse {
    func toAlarm() -> Alarm {
        return Alarm(
            alarmID: alarmID,
            type: .VOIP_NOTIFICATION,
            enable: enable,
            name: name,
            hour: hour,
            minute: minute,
            charaName: "",
            dayOfWeeks: [],
            charaID: "",
            voiceFileName: "",
            sunday: true,
            monday: true,
            tuesday: true,
            wednesday: true,
            thursday: true,
            friday: true,
            saturday: true
        )
    }
}
