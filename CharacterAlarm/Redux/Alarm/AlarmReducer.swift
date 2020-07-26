import Foundation

class AlarmReducer: Reducer {    
    typealias Action = AlarmAction
    typealias State = AlarmState
    
    static func reducer(action: AlarmAction, state: inout AlarmState) {
//        switch action {
//        case let .fetchAlarmList(alarms):
//            state.alarms = alarms
//        case let .deleteAlarms(alarms):
//            state.alarms = alarms
//        case let .updateAlarmEnable(alarms):
//            state.alarms = alarms
//        case let .saveAlarms(alarms):
//            state.alarms = alarms
//        }
    }
}
