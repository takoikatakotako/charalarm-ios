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
    let alarmDispacher = AlarmActionDispacher()
}

fileprivate let dispachers = Dispachers()

struct ConfigView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    @ObservedObject(initialValue: ConfigViewModel()) var viewModel: ConfigViewModel

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: ProfileView(characterId: appState.characterId)) {
                        ProfileHeader(
                            imageUrlString: "https://charalarm.com/image/\(appState.characterId)/thumbnail_list.png", characterName:self.viewModel.character?.name ?? "empty",
                            circleName: self.viewModel.character?.name ?? "xx")
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
            self.viewModel.fetchCharacter(characterId: self.appState.characterId)
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
