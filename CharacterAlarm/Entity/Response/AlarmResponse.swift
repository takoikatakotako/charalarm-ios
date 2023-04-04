import UIKit

struct AlarmResponse: Response {
    let alarmID: UUID
    let userID: UUID
    let type: String
    let enable: Bool
    let name: String
    let hour: Int
    let minute: Int
    let timeDifference: Int
    let charaID: String
    let charaName: String
    let voiceFileName: String
    let sunday: Bool
    let monday: Bool
    let tuesday: Bool
    let wednesday: Bool
    let thursday: Bool
    let friday: Bool
    let saturday: Bool
}

extension AlarmResponse {
    func toAlarm() -> Alarm {
        var dayOfWeeks: [DayOfWeek] = []
        if sunday {
            dayOfWeeks.append(.SUN)
        }
        if tuesday {
            dayOfWeeks.append(.TUE)
        }
        if wednesday {
            dayOfWeeks.append(.WED)
        }
        if thursday {
            dayOfWeeks.append(.THU)
        }
        if friday {
            dayOfWeeks.append(.FRI)
        }
        if saturday {
            dayOfWeeks.append(.SAT)
        }
        
        return Alarm(
            alarmID: alarmID,
            type: .VOIP_NOTIFICATION,
            enable: enable,
            name: name,
            hour: hour,
            minute: minute,
            charaName: charaName,
            dayOfWeeks: dayOfWeeks,
            charaID: charaID,
            voiceFileName: voiceFileName,
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
