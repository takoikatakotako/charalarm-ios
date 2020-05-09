import Foundation

enum AlarmAction: Action {
    case fetchAlarmList([Alarm])
    case updateAlarmEnable([Alarm])
    case deleteAlarms([Alarm])
}
