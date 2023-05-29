import SwiftUI

struct RootView: View {
    @StateObject var viewState: RootViewState
//    @EnvironmentObject var appState: CharalarmAppState
//    @State var remoteConfig: RemoteConfig!
//    
    var body: some View {
        ZStack {
            if viewState.type == .loading {
                Text("Loading")
            } else if viewState.type == .maintenance {
                MaintenanceView()
            } else if viewState.type == .updateRequire {
                UpdateRequiredView()
            } else if viewState.type == .top {
                TopView()
            } else if viewState.type == .tutorial {
                TutorialHolderView()
            }
        }.onAppear {
            viewState.onAppear()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewState: RootViewState())
    }
}
