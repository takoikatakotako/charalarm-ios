import SwiftUI
import CallKit

protocol ObservableState: ObservableObject {
}

class AppState: ObservableState {
    @Published var isCalling: Bool = false
    @Published var characterId: String
    
    @Published var settingState = SettingState()
    init(characterId: String, doneTutorial: Bool) {
        self.characterId = characterId
        self.settingState.doneTutorial = doneTutorial
    }
}
