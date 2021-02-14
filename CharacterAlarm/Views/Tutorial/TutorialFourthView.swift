import SwiftUI

struct TutorialFourthView: View {
    @EnvironmentObject var appState: CharalarmAppState

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Spacer()
            
            Image(R.image.tutorialCharaListScreenShot.name)
                .resizable()
                .scaledToFit()
                .frame(width: 320, height: 400)
                .padding(.bottom, 36)
            
            Spacer()
            
            Text(R.string.localizable.tutorialYouCanSeeTheCharacters())
                .font(Font.system(size: 20))
                .padding(.horizontal, 12)
            
            Text(R.string.localizable.tutorialPleaseChooseYourFavoriteCharacter())
                .font(Font.system(size: 20))
                .padding(.horizontal, 12)
            
            Spacer()
            
            NavigationLink(
                destination: TutorialFifthView().environmentObject(appState),
                label: {
                    TutorialButtonContent(text: R.string.localizable.commonNext())
                        .padding(.horizontal, 16)
                })
                .padding(.bottom, 28)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct TutorialFourthView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TutorialFourthView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            TutorialFourthView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
