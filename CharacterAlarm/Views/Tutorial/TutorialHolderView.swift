import SwiftUI

struct TutorialHolderView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @ObservedObject(initialValue: TutorialHolderViewModel()) var viewModel: TutorialHolderViewModel
    
    @State var views: [TutorialView] = [
        TutorialView(imageName: "sd-normal", text: "チュートリアルだよ"),
        TutorialView(imageName: "sd-happly", text: "チュートリアル"),
        TutorialView(imageName: "sd-sad", text: "チュートリアル"),
        TutorialView(imageName: "sd-smile", text: "チュートリアル"),
        TutorialView(tutorialType: .end,imageName: "sd-suprised", text: "最後のチュートリアル")
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
            }.alert(isPresented: self.$viewModel.showingAlert) {
                Alert(title: Text(""), message: Text("xxx"), dismissButton: .default(Text("xx")))
            }
    }
}

struct TutorialHolderView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialHolderView()
    }
}
