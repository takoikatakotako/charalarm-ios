import SwiftUI

struct UserInfoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var userName: String {
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName() else {
            return ""
        }
        return anonymousUserName
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(R.string.localizable.userInfoUserName())
                .font(Font.body.bold())
            Text(userName)
                .multilineTextAlignment(.leading)
            
            Spacer()
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
        UserInfoView()
    }
}
