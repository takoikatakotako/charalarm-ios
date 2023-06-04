import SwiftUI

struct RootView: View {
    @StateObject var viewState: RootViewState
//    @EnvironmentObject var appState: CharalarmAppState
//    @State var remoteConfig: RemoteConfig!
//    
    var body: some View {
        ZStack {
            if viewState.type == .loading {
                Image(R.image.launchImage.name)
            } else if viewState.type == .maintenance {
                MaintenanceView()
            } else if viewState.type == .updateRequire {
                UpdateRequiredView()
            } else if viewState.type == .top {
                TopView()
            } else if viewState.type == .tutorial {
                TutorialHolderView()
            } else if viewState.type == .calling {
                Text("Calling...")
            }
        }
        .onAppear {
            viewState.onAppear()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.doneTutorial)) { notification in
            viewState.doneTutorial()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.didReset)) { notification in
            viewState.didReset()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.answerCall)) { notification in
            viewState.answerCall()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.endCall)) { notification in
            viewState.endCall()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewState: RootViewState())
    }
}
