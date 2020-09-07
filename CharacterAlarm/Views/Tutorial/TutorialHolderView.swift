import SwiftUI

struct TutorialHolderView: View {
    @EnvironmentObject var appState2: AppState2
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
            .environmentObject(appState2)
            .background(Color.gray)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                self.viewModel.signUp()
        }.alert(isPresented: self.$viewModel.showingAlert) {
            Alert(
                title: Text(""),
                message: Text(self.viewModel.alertMessage),
                primaryButton: .default(Text("ボタンその１")) {
                    print("ボタンその１")
                }, secondaryButton: .destructive(Text("ボタンその２")) {
                    print("ボタンその２")
                })
        }
    }
}

struct TutorialHolderView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialHolderView()
    }
}
