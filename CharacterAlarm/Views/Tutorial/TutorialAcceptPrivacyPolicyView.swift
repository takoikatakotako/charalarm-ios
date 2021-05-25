import SwiftUI
import AdSupport
import AppTrackingTransparency

struct TutorialAcceptPrivacyPolicyView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @State var accountCreated = false
    @State var creatingAccount = false
    @State var showingAlert = false
    @State var alertMessage = ""
    let anonymousUserName = UUID().uuidString
    let anonymousUserPassword = UUID().uuidString
    let userRepository: UserRepository = UserRepository()
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 12) {
                Spacer()
                
                Text(R.string.localizable.tutorialPleaseAcceptThePrivacyPolicy())
                    .font(Font.system(size: 20))
                    .padding(.horizontal, 12)
                
                Button(action: {
                    openPrivacyPolicy()
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
                    isActive: $accountCreated,
                    label: {
                        EmptyView()
                    })
                
                Button(action: {
                    signUp()
                }, label: {
                    TutorialButtonContent(text: R.string.localizable.tutorialAgreeWithThePrivacyPolicy())
                        .padding(.horizontal, 16)
                })
                .padding(.bottom, 28)
            }
            
            if creatingAccount {
                ProgressView()
                    .scaleEffect(2.4, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .frame(width: 160, height: 160)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(16)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("Close")))}
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
    
    private func signUp() {
        guard !creatingAccount else {
            return
        }
        creatingAccount = true
        
        userRepository.signup(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword){ result in
            switch result {
            case .success(_):
                // ユーザー作成に成功
                do {
                    try charalarmEnvironment.keychainHandler.setAnonymousUserName(anonymousUserName: anonymousUserName)
                    try charalarmEnvironment.keychainHandler.setAnonymousUserPassword(anonymousUserPassword: anonymousUserPassword)
                    self.accountCreated = true
                } catch {
                    self.alertMessage = R.string.localizable.tutorialFailedToSaveUserInformation()
                    self.showingAlert = true
                }
                self.creatingAccount = false
                break
            case .failure:
                self.alertMessage = R.string.localizable.commonFailedToConnectWithTheServer()
                self.showingAlert = true
                self.creatingAccount = false
                break
            }
        }
    }
    
    private func trackingAuthorizationNotDetermined() -> Bool {
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .authorized:
            return false
        case .denied:
            return false
        case .restricted:
            return false
        case .notDetermined:
            return true
        @unknown default:
            return false
        }
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
