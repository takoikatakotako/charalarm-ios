import SwiftUI
import CallKit

protocol ObservableState: ObservableObject {
}

class AppState: ObservableState {
    @Published var isCalling: Bool = false
    @Published var characterId: String

    init(characterId: String) {
        self.characterId = characterId
    }
}
