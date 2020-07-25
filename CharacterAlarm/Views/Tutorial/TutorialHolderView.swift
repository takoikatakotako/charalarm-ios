import SwiftUI

struct TutorialHolderView: View {
    @ObservedObject(initialValue: TutorialHolderViewModel()) var viewModel: TutorialHolderViewModel

    @State var views = [
        TutorialView(imageName: "sd-normal", text: "チュートリアルだよ"),
        TutorialView(imageName: "sd-happly", text: "チュートリアル"),
        TutorialView(imageName: "sd-sad", text: "チュートリアル"),
        TutorialView(imageName: "sd-smile", text: "チュートリアル"),
        TutorialView(tutorialType: .end,imageName: "sd-suprised", text: "最後のチュートリアル"),
    ]
    
    var body: some View {
        PageView(views)
            .background(Color.gray)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                print("onAppear")
                self.viewModel.signUp()
        }.alert(isPresented: self.$viewModel.showingAlert) {
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

struct TutorialHolderView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialHolderView()
    }
}
