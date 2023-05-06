import SwiftUI
import AdSupport
import AppTrackingTransparency

struct TutorialAcceptPrivacyPolicyView: View {
    @EnvironmentObject var appState: CharalarmAppState

    @StateObject var viewModel = TutorialAcceptPrivacyPolicyViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 12) {
                Spacer()
                
                Text(R.string.localizable.tutorialPleaseAcceptThePrivacyPolicy())
                    .font(Font.system(size: 20))
                    .padding(.horizontal, 12)
                
                Button(action: {
                    viewModel.openPrivacyPolicy()
                }) {
                    Text(R.string.localizable.tutorialOpenThePrivacyPolicy())
                        .font(Font.system(size: 20))
                }
                
                Image(R.image.sdNormal.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Spacer()
                
                NavigationLink(
                    destination: TutorialRequireTrackingView(),
                    isActive: $viewModel.accountCreated,
                    label: {
                        EmptyView()
                    })
                
                Button(action: {
                    viewModel.signUp()
                }, label: {
                    TutorialButtonContent(text: R.string.localizable.tutorialAgreeWithThePrivacyPolicy())
                        .padding(.horizontal, 16)
                })
                .padding(.bottom, 28)
            }
            
            if viewModel.creatingAccount {
                ProgressView()
                    .scaleEffect(2.4, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .frame(width: 160, height: 160)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(16)
            }
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Close")))}
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct TutorialAcceptPrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TutorialAcceptPrivacyPolicyView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            TutorialAcceptPrivacyPolicyView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}