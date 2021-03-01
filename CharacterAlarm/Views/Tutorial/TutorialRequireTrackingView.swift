import SwiftUI
import AdSupport
import AppTrackingTransparency

struct TutorialRequireTrackingView: View {
    @State var goNextView = false
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Spacer()
            Text("広告をカスタマイズしましょう！")
                .font(Font.system(size: 18).bold())
            
            Text("Charalarmの運営、開発は広告の収益により支えられています。\n適切な広告が表示されるために必要な情報の利用を許可をお願いします。")
                .font(Font.system(size: 18))
                .padding(.horizontal, 12)
            
            Image(R.image.sdNormal.name)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            
            NavigationLink(
                destination: TutorialFinallyView(),
                isActive: $goNextView,
                label: {
                    EmptyView()
                })
            
            Spacer()
            
            Button(action: {
                requestTrackingAuthorization()
            }, label: {
                TutorialButtonContent(text: "カスタマイズした広告を表示")
                    .padding(.horizontal, 16)
            })
            
            Button(action: {
                goNextView = true
            }, label: {
                Text("情報の利用を許可しない")
            })
            .padding(.bottom, 28)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
    func requestTrackingAuthorization() {
        ATTrackingManager.requestTrackingAuthorization { _ in
            goNextView = true
        }
    }
}

struct TutorialRequireTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialRequireTrackingView()
    }
}
