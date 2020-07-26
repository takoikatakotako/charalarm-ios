import SwiftUI

class AppState2 : ObservableObject {
    @Published var doneTutorial: Bool = false
    @Published var settingState = SettingState()
}
