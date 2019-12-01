import SwiftUI

struct ProfileIcon: View {
    var body: some View {
        Image("profile")
            .resizable()
    }
}

struct ProfileView: View {
    var body: some View {
        List {
            Section(header: ProfileIcon()) {
                VStack(alignment: .leading) {
                    Text("名前")
                        .font(Font.headline)
                        .foregroundColor(Color.gray)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    Text("井上結衣")
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 8)

                }

                VStack(alignment: .leading) {
                    Text("プロフィール")
                        .font(Font.headline)
                        .foregroundColor(Color.gray)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    Text("色白で水色の髪と、赤い瞳を持つ細身の少女。エヴァンゲリオン零号機のパイロット（1人目の適格者＝ファーストチルドレン）。EVA零号機の起動実験の事故により重傷を負い、初登場時は包帯姿で登場する。過去の経歴は全て抹消済みであり、本作における最大のキーパーソンとして重大な役割を果たす。")
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 8)

                }

                VStack(alignment: .leading) {
                    Text("サークル名")
                        .font(Font.headline)
                        .foregroundColor(Color.gray)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    Text("旋風鬼")
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 8)

                }

                VStack(alignment: .leading) {
                    Text("CV")
                        .font(Font.headline)
                        .foregroundColor(Color.gray)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    Text("Mai")
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 8)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
