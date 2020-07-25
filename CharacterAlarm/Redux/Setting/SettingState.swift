import Foundation

class SettingState: ObservableState {
    @Published var doneTutorial: Bool = false
    @Published var doneSignUp: Bool = false
}
