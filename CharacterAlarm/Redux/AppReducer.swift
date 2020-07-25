  
import Foundation

protocol Reducer {
    associatedtype Action
    associatedtype State
    static func reducer(action: Action, state: inout State)
}

func appReducer(action: Action, state: inout AppState) {
    switch action {
    case let action as AlertAction:
        AlertReducer.reducer(action: action, state: &state.alertState)
    case let action as AlarmAction:
        AlarmReducer.reducer(action: action, state: &state.alarmState)
    case let setting as SettingAction:
        SettingReducer.reducer(action: setting, state: &state.settingState)
    default:
        break
    }
}
