import SwiftUI

struct TutorialFourthView: View {
    @EnvironmentObject var appState: CharalarmAppState

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Spacer()
            
            Image("tutorial-chara-list-screen-shot")
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
                    Text("つぎへ")
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
    }
}

struct TutorialFourthView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialFourthView()
            .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
    }
}
