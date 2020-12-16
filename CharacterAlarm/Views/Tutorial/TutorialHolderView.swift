import SwiftUI

struct TutorialHolderView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @ObservedObject(initialValue: TutorialHolderViewModel()) var viewModel: TutorialHolderViewModel
    
    @State var views: [AnyView] = [
        AnyView(TutorialView(imageName: "sd-happly", text: "チュートリアル")),
        AnyView(TutorialView(imageName: "sd-sad", text: "チュートリアル")),
        AnyView(TutorialView(imageName: "sd-smile", text: "チュートリアル")),
        AnyView(TutorialView(tutorialType: .end,imageName: "sd-suprised", text: "最後のチュートリアル"))
    ]
    
    var body: some View {
        PageView(views)
            .environmentObject(appState)
            .background(Color.gray)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    guard granted else { return }
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
                self.viewModel.signUp()
            }
            .alert(isPresented: self.$viewModel.showingAlert) {
                Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Close")))
            }
    }
}

struct TutorialHolderView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialHolderView()
    }
}
