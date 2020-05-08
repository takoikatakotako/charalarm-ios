  
import Foundation

protocol Reducer {
    associatedtype Action
    associatedtype State
    static func reducer(action: Action, state: inout State)
}

func appReducer(action: Action, state: inout AppState) {
    switch action {
    case let action as AlarmAction:
        AlarmReducer.reducer(action: action, state: &state.alarmState)
    default:
        break
    }
}
