import Foundation

enum AlarmAction: Action {
    case fetchAlarmList([Alarm])
    case deleteAlarms([Alarm])
}
