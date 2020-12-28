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
            
            Image("sd-normal")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Spacer()
            
            NavigationLink(
                destination: TutorialSecondView()
                    .environmentObject(appState),
                label: {
                    Text("電話をしてもらう")
                        .foregroundColor(Color.white)
                        .font(Font.system(size: 16).bold())
                        .frame(height: 46)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("charalarm-default-green"))
                        .cornerRadius(24)
                        .padding(.horizontal, 16)
                })
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct TutorialFirstView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialFirstView()
            .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
    }
}
