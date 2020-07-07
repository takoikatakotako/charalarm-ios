import SwiftUI

struct TutorialHolderView: View {
    @State var views = [
        TutorialView(imageName: "sd-normal", text: "First"),
        TutorialView(imageName: "sd-happly", text: "Second"),
        TutorialView(imageName: "sd-sad", text: "Third"),
        TutorialView(imageName: "sd-smile", text: "Fourth"),
        TutorialView(tutorialType: .end,imageName: "sd-suprised", text: "First"),
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
