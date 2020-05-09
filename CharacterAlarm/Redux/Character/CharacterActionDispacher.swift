import Foundation

class CharacterActionDispacher {
    
    private let store: AppStore
    
    init(store: AppStore = mainStore) {
        self.store = store
    }
}
