import SwiftUI

final class AppStore: ObservableObject {
    @Published var state: AppState = AppState(characterId: DEFAULT_CHARACTER_DOMAIN, doneTutorial: false)

    public func initState(characterId: String, doneTutorial: Bool) {
        state = AppState(characterId: characterId, doneTutorial: doneTutorial)
    }
    
    public func dispatch(action: Action) {
        // We can't publish changes from a background thread
        // so we enforce reducing from main thread here.
        DispatchQueue.main.async {
            appReducer(action: action, state: &self.state)
        }
    }
}

let mainStore = AppStore()

