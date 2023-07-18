import SwiftUI
import UniformTypeIdentifiers

struct UserInfoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var viewState: UserInfoViewState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading) {
                Text(R.string.localizable.userInfoUserName())
                    .font(Font.body.bold())
                
                Text(viewState.userID)
                    .lineLimit(1)
            }
            
            
            if viewState.showHidenInfos {
                VStack(alignment: .leading) {
                    Text("AuthToken")
                        .font(Font.body.bold())
                    
                    Text(viewState.authToken)
                        .lineLimit(1)
                }
                
                VStack(alignment: .leading) {
                    Text("PushTokenEndpoint")
                        .font(Font.body.bold())
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text(viewState.userInfo?.iOSPlatformInfo.pushTokenSNSEndpoint ?? "Loading")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                
                
                VStack(alignment: .leading) {
                    Text("VoIPPushTokenEndpoint")
                        .font(Font.body.bold())
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text(viewState.userInfo?.iOSPlatformInfo.voIPPushTokenSNSEndpoint ?? "Loading")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                VStack(alignment: .leading) {
                    Text("PushToken")
                        .font(Font.body.bold())
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text(viewState.pushToken ?? "empty")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                VStack(alignment: .leading) {
                    Text("VoIPPushToken")
                        .font(Font.body.bold())
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text(viewState.voipPushToken ?? "empty")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            
            
            Spacer()
            
            Button {
                viewState.tapHidenButton()
            } label: {
                Color.red
                    .frame(height: 40)
                    .frame(minWidth: 0, maxWidth: .infinity)
                
            }
            
        }
        .onAppear {
            viewState.fetchUserInfo()
        }
        .alert(item: $viewState.alert, content: { item in
            Alert(title: Text("SSSS"), message: Text("SSSS"), dismissButton: .default(Text("SSS")))
        })
        .padding()
        .navigationBarTitle(R.string.localizable.userInfoUserInfo(), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                BackBarButton() {
                    presentationMode.wrappedValue.dismiss()
                }
        )
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(viewState: UserInfoViewState())
    }
}
