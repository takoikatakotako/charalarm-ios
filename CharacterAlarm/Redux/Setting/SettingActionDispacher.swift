import Foundation

class SettingActionDispacher {
    private let store: AppStore
    
    init(store: AppStore = mainStore) {
        self.store = store
    }
    
    func doneTutorial(_ done: Bool) {
        self.store.dispatch(action: SettingAction.doneTutorial(done))
    }
}
