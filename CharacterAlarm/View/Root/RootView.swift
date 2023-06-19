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
            } else if viewState.type == .error {
                ErrorView()
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
            let charaID: String? = notification.userInfo?[NSNotification.answerCallUserInfoKeyCharaID] as? String
            let charaName: String? = notification.userInfo?[NSNotification.answerCallUserInfoKeyCharaName] as? String
            let callUUID: UUID? = notification.userInfo?[NSNotification.answerCallUserInfoKeyCallUUID] as? UUID
            viewState.answerCall(charaID: charaID, charaName: charaName, callUUID: callUUID)
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
