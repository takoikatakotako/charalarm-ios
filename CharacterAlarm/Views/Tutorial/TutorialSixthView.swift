import SwiftUI

struct TutorialSixthView: View {
    @EnvironmentObject var appState: CharalarmAppState

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            
            Spacer()
            
            Text("最後に新しいキャラクターの追加のお知らせのなどのため、プッシュ通知の許可をお願いします。")
                .font(Font.system(size: 20))
                .padding(.horizontal, 12)
                .padding(.top, 128)
            
            Image("sd-smile")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Spacer()
            
                        
            Spacer()
            
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
                    .padding(.bottom, 32)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct TutorialSixthView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TutorialSixthView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            TutorialSixthView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
