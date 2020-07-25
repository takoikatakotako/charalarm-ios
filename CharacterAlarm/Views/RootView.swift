import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            if appState.settingState.doneTutorial {
                ContentView()
            } else {
                TutorialHolderView()
            }
        }.alert(isPresented: self.$appState.showingRootAlert) {
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
