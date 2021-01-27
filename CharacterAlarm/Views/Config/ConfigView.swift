import SwiftUI
import SDWebImageSwiftUI

struct ConfigView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject(initialValue: ConfigViewModel()) var viewModel: ConfigViewModel
    @State private var showingResetAlert = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
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
                                    print("リセットをキャンセルしました。")
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
                
                AdmobBannerView(adUnitID: AdmobConfigUnitId)
            }
            .navigationBarTitle("設定", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image("common-icon-close")
                                            .renderingMode(.template)
                                            .foregroundColor(Color("charalarm-default-gray"))
                                    }
            )
        }.onAppear {
            self.viewModel.fetchCharacter()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.setChara)) { _ in
            self.viewModel.fetchCharacter()
        }
        .alert(isPresented: self.$viewModel.showingAlert) {
            Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
            .environmentObject(CharalarmAppState(appVersion: "2.0.4"))
    }
}
