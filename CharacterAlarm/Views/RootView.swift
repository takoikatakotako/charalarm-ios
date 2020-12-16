import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: CharalarmAppState

    
    var body: some View {
        ZStack {
            // if appState.doneTutorial {
            if false {
                TopView()
                .environmentObject(appState)
            } else {
                TutorialFirstView()
                .environmentObject(appState)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
