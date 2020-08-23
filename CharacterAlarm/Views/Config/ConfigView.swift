import SwiftUI
import UIKit

//enum AssetColor: String {
//    case textColor
//    
//    var color: Color {
//        return Color(self.rawValue)
//    }
//}

fileprivate struct Dispachers {
    let settingDispacher = SettingActionDispacher()
}

fileprivate let dispachers = Dispachers()

struct ConfigView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var appState2: AppState2
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject(initialValue: ConfigViewModel()) var viewModel: ConfigViewModel
    @State private var showingResetAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: ProfileView(characterId: appState.characterId)) {
                        ProfileHeader(
                            imageUrlString: "https://charalarm.com/image/\(appState.characterId)/thumbnail.png",
                            characterName: self.viewModel.character?.name ?? "",
                            circleName: self.appState2.circleName,
                            voiceName: self.appState2.voiceName)
                    }.frame(height: 80)
                        .onAppear {
                    }
                }
                
                Section(header: Text("アラーム")) {
                    NavigationLink(destination: AlarmListView(uid: "viewModel.uid")) {
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
                
                Section(header: Text("ユーザー情報")) {
                    NavigationLink(destination: UserInfoView()) {
                        Text("ユーザー情報")
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
                    Button(action: {
                        print("リセット")
                        self.showingResetAlert = true
                    }) {
                        Text("リセット")
                            .foregroundColor(Color("textColor"))
                    }
                    .alert(isPresented: $showingResetAlert) {
                        Alert(
                            title: Text("タイトル"),
                            message: Text("メッセージ"),
                            primaryButton: .default(Text("キャンセル")) {
                                print("ボタンその１")
                            }, secondaryButton: .destructive(Text("リセット")) {
                                self.viewModel.withdraw() {
                                    DispatchQueue.main.async {
                                        self.appState2.doneTutorial = false
                                    }
                                }
                            })
                    }
                }
                
            }.listStyle(GroupedListStyle())
                .navigationBarTitle("設定", displayMode: .inline)
                .navigationBarItems(leading:
                    Button("閉じる") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            )
        }.onAppear {
            guard let characterId = UserDefaults.standard.string(forKey: CHARACTER_DOMAIN) else {
                fatalError("characterIdが取得できませんでした")
            }
            self.viewModel.fetchCharacter(characterId: characterId)
        }.alert(isPresented: self.$viewModel.showingAlert) {
            Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
        }
    }
    
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
