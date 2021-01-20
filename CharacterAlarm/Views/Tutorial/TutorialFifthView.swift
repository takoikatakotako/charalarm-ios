import SwiftUI

struct TutorialFifthView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @State var accountCreated = false
    @State var creatingAccount = false
    @State var showingAlert = false
    @State var alertMessage = ""
    let anonymousUserName = UUID().uuidString
    let anonymousUserPassword = UUID().uuidString
    
    var body: some View {
        ZStack {
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
                    destination: TutorialSixthView(),
                    isActive: $accountCreated,
                    label: {
                        EmptyView()
                    })
                
                Button(action: {
                    signUp()
                }, label: {
                    TutorialButtonContent(text: "プライバシーポリシーに同意する")
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
        
        UserStore.signup(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword){ result in
            switch result {
            case .success(_):
                // ユーザー作成に成功
                do {
                    try KeychainHandler.setAnonymousUserName(anonymousUserName: anonymousUserName)
                    try KeychainHandler.setAnonymousUserPassword(anonymousUserPassword: anonymousUserPassword)
                    self.accountCreated = true
                } catch {
                    self.alertMessage = "ユーザー情報の保存に設定に失敗しました。"
                    self.showingAlert = true
                }
                self.creatingAccount = false
                break
            case .failure:
                self.alertMessage = "サーバーとの通信に失敗しました。時間をあけて後ほどお試しください。"
                self.showingAlert = true
                self.creatingAccount = false
                break
            }
        }
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
