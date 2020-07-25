import SwiftUI

fileprivate struct Dispachers {
    let settingDispacher = SettingActionDispacher()
}

fileprivate let dispachers = Dispachers()

struct TutorialView: View {
    @EnvironmentObject var appState: AppState

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
                    withAnimation {
                        if self.appState.settingState.doneSignUp {
                            dispachers.settingDispacher.doneTutorial(true)
                        } else {
                            print("xxxx")
                        }
                    }
                }) {
                    Text("Hello")
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
