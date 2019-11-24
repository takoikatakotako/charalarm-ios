import SwiftUI
import UIKit

struct ConfigView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: ProfileView()) {
                        ProfileHeader()
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
                    Button(action: {
                        guard let url = URL(string: OfficialTwitterUrlString) else {
                            return
                        }
                        UIApplication.shared.open(url)
                    }) {
                        Text("公式Twitter")
                            .foregroundColor(Color.black)
                    }

                    Button(action: {
                        guard let url = URL(string: ContactAboutAppUrlString) else {
                            return
                        }
                        UIApplication.shared.open(url)
                    }) {
                        Text("アプリについてのお問い合わせ")
                        .foregroundColor(Color.black)
                    }

                    Button(action: {
                        guard let url = URL(string: ContactAbountAddCharacterUrlString) else {
                            return
                        }
                        UIApplication.shared.open(url)
                    }) {
                        Text("キャラクター追加のお問い合わせ")
                        .foregroundColor(Color.black)
                    }
                }

                Section(header: Text("アプリケーション情報")) {
                    HStack {
                        Text("バージョン情報")
                        Spacer()
                        Text("2.0.0(234)")
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
