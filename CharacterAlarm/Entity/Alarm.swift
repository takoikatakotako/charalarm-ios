import UIKit
import FirebaseFirestore

struct Alarm: CustomStringConvertible, Identifiable, Hashable {
    static let collectionName = "alarm"
    static let id = "id"
    static let uid = "uid"
    static let voipToken = "voip_token"
    static let createTime = "create_time"
    static let updateTime = "update_time"
    static let name = "name"
    static let hour = "hour"
    static let minute = "minute"
    static let timeDifference = "time_difference"
    static let sunday = "sunday"
    static let monday = "monday"
    static let tuesday = "tuesday"
    static let wednesday = "wednesday"
    static let thusday = "thusday"
    static let friday = "friday"
    static let saturday = "saturday"

    let id: String
    let uid: String
    let voipToken: String
    var createTime: Date
    let updateTime: Date
    var name: String
    var hour: Int
    var minute: Int
    var timeDifference: Int
    var sunday: Bool = true
    var monday: Bool = true
    var tuesday: Bool = true
    var wednesday: Bool = true
    var thursday: Bool = true
    var friday: Bool = true
    var saturday: Bool = true

    var description: String {
        return "\(String(format: "%02d", hour + timeDifference)):\(String(format: "%02d", minute)) (GMT+\(timeDifference))"
    }

    var enableDayObWeek: EnableDayOfWeek {
        return EnableDayOfWeek(
            sunday: sunday,
            monday: monday,
            tuesday: tuesday,
            wednesday: wednesday,
            thursday: thursday,
            friday: friday,
            saturday: saturday)
    }

    var data: [String: Any] {
        var data: [String: Any] = [:]
        data[Alarm.id] = id
        data[Alarm.uid] = uid
        data[Alarm.voipToken] = voipToken
        data[Alarm.createTime] = createTime
        data[Alarm.updateTime] = updateTime
        data[Alarm.name] = name
        data[Alarm.hour] = hour
        data[Alarm.minute] = minute
        data[Alarm.timeDifference] = timeDifference
        data[Alarm.sunday] = sunday
        data[Alarm.monday] = monday
        data[Alarm.tuesday] = tuesday
        data[Alarm.wednesday] = wednesday
        data[Alarm.thusday] = thursday
        data[Alarm.friday] = friday
        data[Alarm.saturday] = saturday
        return data
    }

    init(uid: String, token: String) {
        self.id = NSUUID().uuidString
        self.uid = uid
        self.voipToken = token
        let date = Date()
        self.createTime = date
        self.updateTime = date
        self.name = date.description

        let timeZone = TimeZone.current
        self.timeDifference =  timeZone.secondsFromGMT() / 3600

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        self.hour = (hour - timeDifference >= 0) ? hour - timeDifference : hour - timeDifference + 24
        self.minute = calendar.component(.minute, from: date)
    }

    init(id: String, document: DocumentSnapshot) {
        self.id = id
        if let uid = document.get(Alarm.uid) as? String {
            self.uid = uid
        } else {
            self.uid = "xxxxxx"
        }

        if let voipToken = document.get(Alarm.voipToken) as? String {
            self.voipToken = voipToken
        } else {
            self.voipToken = "xxxxxx"
        }

        if let createTime = document.get(Alarm.createTime) as? Timestamp {
            self.createTime = createTime.dateValue()
        } else {
            createTime = Date()
        }

        if let updateTime = document.get(Alarm.updateTime) as? Timestamp {
            self.updateTime = updateTime.dateValue()
        } else {
            updateTime = Date()
        }

        if let name = document.get(Alarm.name) as? String {
            self.name = name
        } else {
            name = "No Name"
        }

        // TODO: AlarmTimeとAlarmDayOfWeekがなんかもっといい感じにできそうな気がする
        if let hour = document.get(Alarm.hour) as? Int {
            self.hour = hour
        } else {
            // TODO: ここちゃんとやる
            self.hour = 0
        }

        if let minute = document.get(Alarm.minute) as? Int {
            self.minute = minute
        } else {
            self.minute = 0
        }

        if let sunday = document.get(Alarm.sunday) as? Bool {
            self.sunday = sunday
        } else {
            self.sunday = false
        }

        if let monday = document.get(Alarm.monday) as? Bool {
            self.monday = monday
        } else {
            self.monday = false
        }

        if let tuesday = document.get(Alarm.tuesday) as? Bool {
            self.tuesday = tuesday
        } else {
            self.tuesday = false
        }

        if let wednesday = document.get(Alarm.wednesday) as? Bool {
            self.wednesday = wednesday
        } else {
            self.wednesday = false
        }

        if let thusday = document.get(Alarm.thusday) as? Bool {
            self.thursday = thusday
        } else {
            self.thursday = false
        }

        if let friday = document.get(Alarm.friday) as? Bool {
            self.friday = friday
        } else {
            self.friday = false
        }

        if let saturday = document.get(Alarm.saturday) as? Bool {
            self.saturday = saturday
        } else {
            self.saturday = false
        }

        if let timeDiffarence = document.get(Alarm.timeDifference) as? Int {
            self.timeDifference = timeDiffarence
        } else {
            let timeZone = TimeZone.current
            self.timeDifference =  timeZone.secondsFromGMT() / 3600
        }
    }
}
