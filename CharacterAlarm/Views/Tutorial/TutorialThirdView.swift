import SwiftUI

struct TutorialThirdView: View {
    @EnvironmentObject var appState: CharalarmAppState

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Spacer()
            
            Image(R.image.tutorialAlarmScreenShot.name)
                .resizable()
                .scaledToFit()
                .frame(width: 320, height: 400)
                .padding(.bottom, 36)
            
            Text(R.string.localizable.tutorialDidYouGetACall())
                .font(Font.system(size: 20))
                .padding(.horizontal, 12)
            
            Text(R.string.localizable.tutorialYouCanSetMultipleAlarms())
                .font(Font.system(size: 20))
                .padding(.horizontal, 12)
            
            Spacer()
            
            NavigationLink(
                destination: TutorialCharaListView()
                    .environmentObject(appState),
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

struct TutorialThirdView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TutorialThirdView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            TutorialThirdView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
