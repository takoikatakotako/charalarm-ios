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
                    Text("井上結衣")
                }

                VStack(alignment: .leading) {
                    Text("プロフィール")
                    Text("色白で水色の髪と、赤い瞳を持つ細身の少女。エヴァンゲリオン零号機のパイロット（1人目の適格者＝ファーストチルドレン）。EVA零号機の起動実験の事故により重傷を負い、初登場時は包帯姿で登場する。過去の経歴は全て抹消済みであり、本作における最大のキーパーソンとして重大な役割を果たす。")
                }

                VStack(alignment: .leading) {
                    Text("サークル名")
                    Text("旋風鬼")
                }

                VStack(alignment: .leading) {
                    Text("CV")
                    Text("Mai")
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
