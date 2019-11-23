import SwiftUI

struct ConfigView: View {
    var body: some View {
        List {
            Section {
                NavigationLink(destination: ProfileView()) {
                    ProfileHeaderView()
                }.frame(height: 80)
            }

            Section(header: Text("アラーム")) {
                NavigationLink(destination: AlarmListView()) {
                    Text("アラーム")
                }
            }

            Section(header: Text("キャラクター")) {
                NavigationLink(destination: CharacterList()) {
                    Text("キャラクター")
                }
            }

            Section(header: Text("その他")) {
                Text("公式Twitter")
                Text("アプリについてのお問い合わせ")
                Text("キャラクター追加のお問い合わせ")
            }

            Section(header: Text("アプリケーション情報")) {
                Text("バージョン情報")
                Text("ライセンス")
            }

            Section(header: Text("リセット")) {
                Text("リセット")
            }
        }.listStyle(GroupedListStyle())
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
