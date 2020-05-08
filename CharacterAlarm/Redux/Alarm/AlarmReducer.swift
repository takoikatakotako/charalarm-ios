import Foundation

class AlarmReducer: Reducer {
    typealias Action = AlarmAction
    typealias State = AlarmState
    
    static func reducer(action: AlarmAction, state: inout AlarmState) {
        switch action {
        case let .fetchAlarmList(alams):
            state.alarms = alams
        }
    }
}
