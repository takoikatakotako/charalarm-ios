import SwiftUI

struct TutorialHolderView: View {
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
    }
}

struct TutorialHolderView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialHolderView()
    }
}
