import SwiftUI

class AppState2 : ObservableObject {
    @Published var doneTutorial: Bool = false
    @Published var charaDomain: String = DEFAULT_CHARACTER_DOMAIN
    @Published var charaName: String = ""
    @Published var circleName: String = ""
    @Published var voiceName: String = ""
}
