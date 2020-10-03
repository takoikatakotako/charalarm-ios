import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct ConfigView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject(initialValue: ConfigViewModel()) var viewModel: ConfigViewModel
    @State private var showingResetAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: ProfileView(characterId: appState.charaDomain)) {
                        HStack {
                            WebImage(url: URL(string: "https://charalarm.com/image/\(appState.charaDomain)/thumbnail.png"))
                                .resizable()
                                .placeholder {
                                    Image("character-placeholder")
                                        .resizable()
                                }
                                .animation(.easeInOut(duration: 0.5))
                                .transition(.fade)
                                .scaledToFill()
                                .frame(width: 76, height: 76, alignment: .center)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(viewModel.character?.name ?? "")
                                    .foregroundColor(.gray)
                                    .font(Font.system(size: 24))
                                Text("\(appState.circleName) / \(appState.voiceName)")
                                    .foregroundColor(.gray)
                                    .font(Font.system(size: 18))
                                    .padding(.top, 8)
                            }
                        }
                    }.frame(height: 80)
                    .onAppear {
                    }
                }
                
                Section(header: Text("アラーム")) {
                    NavigationLink(destination: AlarmListView()) {
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
                    Button {
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        UIApplication.shared.open(settingsUrl, completionHandler: nil)
                    } label: { 
                        Text("ライセンス")
                            .foregroundColor(Color("textColor"))
                    }
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
                            title: Text("リセット"),
                            message: Text("リセットしてよろしいですか？"),
                            primaryButton: .default(Text("キャンセル")) {
                                print("ボタンその１")
                            }, secondaryButton: .destructive(Text("リセット")) {
                                self.viewModel.withdraw() {
                                    DispatchQueue.main.async {
                                        self.appState.doneTutorial = false
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
