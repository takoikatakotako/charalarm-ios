import SwiftUI

struct UserInfoView: View {
    
    var userName: String {
        guard let anonymousUserName = UserDefaultsStore.getAnonymousUserName() else {
            return ""
        }
        return anonymousUserName
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("ユーザー名")
                .font(Font.body.bold())
            Text(userName)
            Spacer()
        }
        .padding()
        .navigationBarTitle("ユーザー情報", displayMode: .inline)
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
