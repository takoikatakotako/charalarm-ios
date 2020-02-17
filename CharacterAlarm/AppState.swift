import SwiftUI
import CallKit

class AppState: ObservableObject {
    @Published var isCalling: Bool = false
    @Published var characterId: String

    init(characterId: String) {
        self.characterId = characterId
    }
}
