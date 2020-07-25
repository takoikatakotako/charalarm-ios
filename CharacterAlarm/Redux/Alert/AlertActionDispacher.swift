import Foundation

class AlertActionDispacher {
    private let store: AppStore
    
    init(store: AppStore = mainStore) {
        self.store = store
    }
    
    func showingAlert(_ done: Bool) {
        self.store.dispatch(action: AlertAction.showingAlert(done))
    }
}
