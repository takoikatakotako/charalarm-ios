import SwiftUI

class CharalarmAppState: ObservableObject {
    @Published var doneTutorial: Bool = false
    @Published var underMaintenance: Bool = false
    @Published var appVersion: String
    @Published var requiredVersion: String
    
    init(appVersion: String) {
        self.appVersion = appVersion
        self.requiredVersion = appVersion
    }
}
