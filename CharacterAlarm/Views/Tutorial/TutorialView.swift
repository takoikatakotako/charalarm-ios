import SwiftUI

struct TutorialView: View {    
    let tutorialType: TutorialType
    let imageName: String
    let text: String
    
    init(
        tutorialType: TutorialType = .intermidiate,
        imageName: String,
        text: String) {
        self.tutorialType = tutorialType
        self.imageName = imageName
        self.text = text
    }
    
    @ViewBuilder
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Spacer()
                Text(text)
                HStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Spacer()
                }
                Spacer()
            }
            .background(Color.gray)
            .edgesIgnoringSafeArea(.all)
            
            if tutorialType == .end {
                Button(action: {

                }) {
                    Text("アプリを使ってみる")
                        .foregroundColor(Color.white)
                }
                .background(Color.gray)
                .edgesIgnoringSafeArea(.all)
            }
            
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(imageName: "snorlax", text: "This is Tutorial!")
    }
}
