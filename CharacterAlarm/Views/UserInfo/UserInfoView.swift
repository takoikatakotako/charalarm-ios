import SwiftUI

struct UserInfoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var userName: String {
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName() else {
            return ""
        }
        return anonymousUserName
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("ユーザー名")
                .font(Font.body.bold())
            Text(userName)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("ユーザー情報", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
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
