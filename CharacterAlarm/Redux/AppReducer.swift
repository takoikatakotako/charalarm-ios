  
import Foundation

protocol Reducer {
    associatedtype Action
    associatedtype State
    static func reducer(action: Action, state: inout State)
}

func appReducer(action: Action, state: inout AppState) {
//    switch action {
//    case let action as CampusLogoAction:
//        CampusLogoReducer.reducer(action: action, state: &state.logoState)
//    case let action as DeviceAction:
//        DeviceReducer.reducer(action: action, state: &state.deviceState)
//    case let action as UserAccountAction:
//        UserAccountReducer.reducer(action: action, state: &state.userAccountState)
//    default:
//        break
//    }
}
