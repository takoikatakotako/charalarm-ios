import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: CharalarmAppState

    
    var body: some View {
        ZStack {
            if appState.doneTutorial {
                ContentView()
                .environmentObject(appState)
            } else {
                TutorialHolderView()
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
