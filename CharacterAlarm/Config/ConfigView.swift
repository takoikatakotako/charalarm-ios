import SwiftUI
import UIKit

struct ConfigView: View {
    @ObservedObject(initialValue: ConfigViewModel()) var viewModel: ConfigViewModel

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: ProfileView(profile: Profile())) {
                        ProfileHeader()
                    }.frame(height: 80)
                }

                Section(header: Text("アラーム")) {
                    NavigationLink(destination: AlarmListView(uid: "sdfsdf")) {
                        Text("アラーム")
                    }
                }

                Section(header: Text("キャラクター")) {
                    NavigationLink(destination: CharacterListView()) {
                        Text("キャラクター")
                    }
                }

                Section(header: Text("その他")) {
                    Button(action: {
                        self.viewModel.openUrlString(string: OfficialTwitterUrlString)
                    }) {
                        Text("公式Twitter")
                            .foregroundColor(Color.black)
                    }

                    Button(action: {
                       self.viewModel.openUrlString(string: ContactAboutAppUrlString)
                    }) {
                        Text("アプリについてのお問い合わせ")
                        .foregroundColor(Color.black)
                    }

                    Button(action: {
                        self.viewModel.openUrlString(string: ContactAbountAddCharacterUrlString)
                    }) {
                        Text("キャラクター追加のお問い合わせ")
                        .foregroundColor(Color.black)
                    }
                }

                Section(header: Text("アプリケーション情報")) {
                    HStack {
                        Text("バージョン情報")
                        Spacer()
                        Text(viewModel.versionString)
                    }
                    Text("ライセンス")
                }

                Section(header: Text("リセット")) {
                    Text("リセット")
                }
            }.listStyle(GroupedListStyle())
                .navigationBarTitle("設定", displayMode: .inline)
                .navigationBarItems(leading:
                        Button("閉じる") {
                            print("Help tapped!")
                    }
                )
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
