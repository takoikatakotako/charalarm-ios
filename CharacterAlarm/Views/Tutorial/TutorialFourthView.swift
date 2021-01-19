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
            
            Text("キャラクター一覧から着信を受けられるキャラクターを見ることができます。")
                .font(Font.system(size: 20))
                .padding(.horizontal, 12)
            
            Text("好きなキャラクターを選んでみてください。")
                .font(Font.system(size: 20))
                .padding(.horizontal, 12)
            
            Spacer()
            
            NavigationLink(
                destination: TutorialFifthView().environmentObject(appState),
                label: {
                    TutorialButtonContent(text: "つぎへ")
                        .padding(.horizontal, 16)
                })
                .padding(.bottom, 32)
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
