import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: CharalarmAppState

    @State var showingAlert = false
    
    var body: some View {
        Group {
            if appState.doneTutorial {
                ContentView()
                .environmentObject(appState)
            } else {
                TutorialHolderView()
                .environmentObject(appState)
            }
        }.alert(isPresented: $showingAlert) {
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
