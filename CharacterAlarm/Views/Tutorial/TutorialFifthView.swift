import SwiftUI

struct TutorialFifthView: View {
    @EnvironmentObject var appState: CharalarmAppState

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Image("sd-normal")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Spacer()
            
            
            Text("プッシュ通知なんとかかんとか")
            
            Button(action: {
                appState.doneTutorial = true
            }) {
                Text("ホーム画面へ")
                    .foregroundColor(Color.white)
                    .font(Font.system(size: 16).bold())
                    .frame(height: 46)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color("charalarm-default-green"))
                    .cornerRadius(24)
                    .padding(.horizontal, 16)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct TutorialFifthView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialFifthView()
    }
}
