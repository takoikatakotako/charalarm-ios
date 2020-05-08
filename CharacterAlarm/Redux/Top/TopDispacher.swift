import Foundation

class TopActionDispacher {
    private var store = AppStore()
    
    init(store: AppStore = mainStore) {
        self.store = store
    }
    
    func feach() {
//        store.dispatch(action: TopAction.xxxxxx)
    }
}
