import SwiftUI

final class AppStore: ObservableObject {
//
//    @Published private(set) var state: AppState = AppState()
//
//    public func dispatch(action: Action) {
//        // We can't publish changes from a background thread
//        // so we enforce reducing from main thread here.
//        DispatchQueue.main.async {
//            appReducer(action: action, state: &self.state)
//        }
//    }
}

let mainStore = AppStore()