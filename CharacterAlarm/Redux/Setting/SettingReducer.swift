import Foundation

class SettingReducer: Reducer {
    typealias Action = SettingAction
    typealias State = SettingState
    
    static func reducer(action: SettingAction, state: inout SettingState) {
        switch action {
        case let .doneTutorial(doneTutorial):
            state.doneTutorial = doneTutorial
        }
    }
}
