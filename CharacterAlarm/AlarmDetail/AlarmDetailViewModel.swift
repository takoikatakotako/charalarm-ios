import Foundation
import SwiftUI

class AlarmDetailViewModel: ObservableObject {
    @Published var alarm: Alarm
    @Published var showingAlert = false

    var alarmName: String {
        return alarm.name
    }

    var alarmTimeString: String {
        return "\(alarm.hour + alarm.timeDifference):\(alarm.minute)(GMT+\(alarm.timeDifference))"
    }

    init(uid: String, alarm: Alarm) {
        self.alarm = alarm
    }

    func saveButton() {
        AlarmStore.save(alarm: alarm) { error in
            if let error = error {
                print(error)
            } else {
                self.showingAlert = true
            }
        }
    }

    func updateAlarmName(name: String) {
        alarm.name = name
    }

    func updateAlarmTime(hour: Int, minute: Int) {
        alarm.hour = hour
        alarm.minute = minute
    }

    func updateTimeDifference(timeDifference: Int) {
        alarm.timeDifference = timeDifference
    }

    func updateDayOfWeek(enableDayOfWeek: EnableDayOfWeek) {
        alarm.sunday = enableDayOfWeek.sunday
        alarm.monday = enableDayOfWeek.monday
        alarm.tuesday = enableDayOfWeek.tuesday
        alarm.wednesday = enableDayOfWeek.wednesday
        alarm.thursday = enableDayOfWeek.thursday
        alarm.friday = enableDayOfWeek.friday
        alarm.saturday = enableDayOfWeek.saturday
    }
}
