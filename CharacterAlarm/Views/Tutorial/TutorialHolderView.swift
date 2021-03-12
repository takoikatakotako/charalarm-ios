import SwiftUI

struct TutorialHolderView: View {
    @EnvironmentObject var appState: CharalarmAppState

    var body: some View {
        NavigationView {
            TutorialIntroductionView()
                .environmentObject(appState)
        }
    }
}

struct TutorialHolderView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialHolderView()
    }
}
