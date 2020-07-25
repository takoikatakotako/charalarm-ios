import Foundation

class AlertReducer: Reducer {
    typealias Action = AlertAction
    typealias State = AlertState
    
    static func reducer(action: AlertAction, state: inout AlertState) {
        switch action {
        case let .showingAlert(showingAlert):
            state.showingAlert = showingAlert
        }
    }
}
