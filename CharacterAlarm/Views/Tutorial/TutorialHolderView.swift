import SwiftUI

fileprivate struct Dispachers {
    let settingDispacher = SettingActionDispacher()
}

fileprivate let dispachers = Dispachers()

struct TutorialHolderView: View {
    @State var views = [
        TutorialView(imageName: "snorlax", text: "First"),
        TutorialView(imageName: "pikachu", text: "Second"),
        TutorialView(imageName: "slowpoke", text: "Third"),
        TutorialView(imageName: "coil", text: "Fourth"),
    ]
    
    var body: some View {
        //        PageView(views)
        //            .background(Color.gray)
        //            .edgesIgnoringSafeArea(.all)
        
        
        Button(action: {
            withAnimation {
                dispachers.settingDispacher.doneTutorial(true)
            }
        }) {
            Text("Hello")
        }
    }
}

struct TutorialHolderView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialHolderView()
    }
}
