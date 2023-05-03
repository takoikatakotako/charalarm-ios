import SwiftUI

struct UserInfoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var viewState: UserInfoViewState

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(R.string.localizable.userInfoUserName())
                .font(Font.body.bold())
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Text(viewState.userInfo?.userID.description ?? "Loading")
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

            Text("AuthToken")
                .font(Font.body.bold())
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Text(viewState.userInfo?.authToken ?? "Loading")
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

            Text("PushTokenEndpoint")
                .font(Font.body.bold())
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Text(viewState.userInfo?.iosPushTokens.snsEndpointArn ?? "Loading")
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Text("VoIPPushTokenEndpoint")
                .font(Font.body.bold())
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Text(viewState.userInfo?.iosVoIPPushTokens.snsEndpointArn ?? "Loading")
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

            Spacer()
        }
        .onAppear {
            viewState.fetchUserInfo()
        }
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
