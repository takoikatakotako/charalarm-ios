import SwiftUI

struct ProfileIcon: View {
    var body: some View {
        Image("profile")
            .resizable()
    }
}

struct ProfileView: View {
    let profile: Profile
    var body: some View {
        List {
            Section(header: ProfileIcon()) {
                VStack(alignment: .leading) {
                    Text("名前")
                        .font(Font.headline)
                        .foregroundColor(Color.gray)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    Text(profile.name)
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 8)

                }

                VStack(alignment: .leading) {
                    Text("プロフィール")
                        .font(Font.headline)
                        .foregroundColor(Color.gray)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    Text(profile.description)
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 8)

                }

                VStack(alignment: .leading) {
                    Text("サークル名")
                        .font(Font.headline)
                        .foregroundColor(Color.gray)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    Text(profile.circleName)
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 8)

                }

                VStack(alignment: .leading) {
                    Text("CV")
                        .font(Font.headline)
                        .foregroundColor(Color.gray)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    Text(profile.circleName)
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 8)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: Profile())
    }
}
