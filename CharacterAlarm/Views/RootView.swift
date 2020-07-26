import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var appState2: AppState2

    var body: some View {
        Group {
            if appState2.doneTutorial {
                ContentView()
                .environmentObject(appState)
                .environmentObject(appState2)
            } else {
                TutorialHolderView()
                .environmentObject(appState)
                .environmentObject(appState2)
            }
        }.alert(isPresented: self.$appState.alertState.showingAlert) {
            Alert(
                title: Text("タイトル"),
                message: Text("メッセージ"),
                primaryButton: .default(Text("ボタンその１")) {
                    print("ボタンその１")
                }, secondaryButton: .destructive(Text("ボタンその２")) {
                    print("ボタンその２")
                })
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
