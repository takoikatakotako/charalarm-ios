import SwiftUI

struct TutorialFifthView: View {
    @EnvironmentObject var appState: CharalarmAppState

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Spacer()
            
            Text("プライバシーポリシーへの同意をお願いします。")
                .font(Font.system(size: 20))
                .padding(.horizontal, 12)
            
            Button(action: {
                openPrivacyPolicy()
            }) {
                Text("プライバシーポリシーを開く")
                    .font(Font.system(size: 20))
            }
            
            Image(R.image.sdNormal.name)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Spacer()
            
            NavigationLink(
                destination: TutorialSixthView()
                    .environmentObject(appState),
                label: {
                    TutorialButtonContent(text: "プライバシーポリシーに同意する")
                        .padding(.horizontal, 16)
                })
                .padding(.bottom, 32)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
    private func openPrivacyPolicy() {
        guard let url = URL(string: PrivacyPolicyUrlString) else {
            return
        }
        UIApplication.shared.open(url)
    }
}

struct TutorialFifthView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TutorialFifthView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            TutorialFifthView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
