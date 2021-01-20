import SwiftUI

struct TutorialFirstView: View {
    @EnvironmentObject var appState: CharalarmAppState
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Spacer()
            Text("キャラームへようこそ！")
                .font(Font.system(size: 20))
            
            Text("このアプリは設定した時間にキャラクターが電話をしてくれるアプリです。")
                .font(Font.system(size: 20))
                .padding(.horizontal, 12)
            
            Text("さっそく試してみましょう！")
                .font(Font.system(size: 20))
            
            Image(R.image.sdNormal.name)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Spacer()
            
            NavigationLink(
                destination: TutorialSecondView()
                    .environmentObject(appState),
                label: {
                    TutorialButtonContent(text: "電話をしてもらう")
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
            TutorialFirstView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            TutorialFirstView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
