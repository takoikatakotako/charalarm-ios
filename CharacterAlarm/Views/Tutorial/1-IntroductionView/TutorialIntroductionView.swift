import SwiftUI

struct TutorialIntroductionView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Spacer()
            Text(R.string.localizable.tutorialWelcomeToCharalarm())
                .font(Font.system(size: 20))
            
            Text(R.string.localizable.tutorialThisIsAnApp())
                .font(Font.system(size: 20))
                .padding(.horizontal, 12)
            
            Text(R.string.localizable.tutorialLetUsTryItNow())
                .font(Font.system(size: 20))
            
            Image(R.image.sdNormal.name)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Spacer()
            
            NavigationLink(
                destination: TutorialCallView(),
                label: {
                    TutorialButtonContent(text: R.string.localizable.tutorialGetACall())
                        .padding(.horizontal, 16)
                })
                .padding(.bottom, 28)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarHidden(true)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct TutorialFirstView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TutorialIntroductionView()
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            TutorialIntroductionView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
