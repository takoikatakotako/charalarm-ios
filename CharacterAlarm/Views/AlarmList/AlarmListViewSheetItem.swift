import Foundation

enum AlarmListViewSheetItem: Identifiable {
    case alarmDetail(Alarm)
    var id: String {
        switch self {
        case let .alarmDetail(alarm):
            return alarm.id
        }
    }
}
