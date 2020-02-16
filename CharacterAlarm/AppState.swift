import SwiftUI
import CallKit

class AppState: ObservableObject {
    @Published var isCalling: Bool = false
}
