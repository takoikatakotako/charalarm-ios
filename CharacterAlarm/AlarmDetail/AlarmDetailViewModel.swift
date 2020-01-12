import Foundation

class AlarmDetailViewModel: ObservableObject {
    @Published var alarm: Alarm

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
            }
        }
    }

    func updateAlarmName(name: String) {
        alarm.name = name
    }
}
