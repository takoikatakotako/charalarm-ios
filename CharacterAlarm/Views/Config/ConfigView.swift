import SwiftUI
import UIKit

enum AssetColor: String {
    case textColor

    var color: Color {
        return Color(self.rawValue)
    }
}

struct ConfigView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel = ConfigViewModel()
    @State var profile: Profile?

    init() {
        UINavigationBar.appearance().tintColor = UIColor(named: AssetColor.textColor.rawValue)
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    if profile == nil {
                        ProfileHeader(characterId: appState.characterId)
                            .frame(height: 80)
                    } else {
                        NavigationLink(destination: ProfileView(profile: profile!)) {
                            ProfileHeader(characterId: appState.characterId)
                        }.frame(height: 80)
                            .onAppear {
                                self.featchProfile()
                        }
                    }
                }

                Section(header: Text("アラーム")) {
                    NavigationLink(destination: AlarmListView(uid: viewModel.uid)) {
                        Text("アラーム")
                            .foregroundColor(Color("textColor"))
                    }
                }

                Section(header: Text("キャラクター")) {
                    NavigationLink(destination: CharacterListView()) {
                        Text("キャラクター")
                            .foregroundColor(Color("textColor"))
                    }
                }

                Section(header: Text("その他")) {
                    Button(action: {
                        self.viewModel.openUrlString(string: OfficialTwitterUrlString)
                    }) {
                        Text("公式Twitter")
                            .foregroundColor(Color("textColor"))
                    }

                    Button(action: {
                        self.viewModel.openUrlString(string: ContactAboutAppUrlString)
                    }) {
                        Text("アプリについてのお問い合わせ")
                            .foregroundColor(Color("textColor"))
                    }

                    Button(action: {
                        self.viewModel.openUrlString(string: ContactAbountAddCharacterUrlString)
                    }) {
                        Text("キャラクター追加のお問い合わせ")
                            .foregroundColor(Color("textColor"))
                    }
                }

                Section(header: Text("アプリケーション情報")) {
                    HStack {
                        Text("バージョン情報")
                            .foregroundColor(Color("textColor"))
                        Spacer()
                        Text(viewModel.versionString)
                            .foregroundColor(Color("textColor"))
                    }
                    Text("ライセンス")
                        .foregroundColor(Color("textColor"))
                }

                Section(header: Text("リセット")) {
                    Text("リセット")
                        .foregroundColor(Color("textColor"))
                }
            }.listStyle(GroupedListStyle())
                .navigationBarTitle("設定", displayMode: .inline)
                .navigationBarItems(leading:
                    Button("閉じる") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            )
        }.onAppear {
            self.featchProfile()
        }
    }

    func featchProfile() {
        ProfileStore.featchProfile(characterId: appState.characterId) { (profile, _) in
            guard let profile = profile else {
                return
            }
            self.profile = profile
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
