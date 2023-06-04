import SwiftUI
import SDWebImageSwiftUI

struct ConfigView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject(initialValue: ConfigViewModel()) var viewModel: ConfigViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    Section(header: Text(R.string.localizable.configUserInfo())) {
                        NavigationLink(destination: UserInfoView(viewState: UserInfoViewState())) {
                            Text(R.string.localizable.configUserInfo())
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                    }
                    
                    Section(header: Text(R.string.localizable.configOther())) {
                        Button(action: {
                            viewModel.openUrlString(string: OfficialTwitterUrlString)
                        }) {
                            Text(R.string.localizable.configOfficialTwitter())
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                        
                        Button(action: {
                            viewModel.openUrlString(string: ContactAboutAppUrlString)
                        }) {
                            Text(R.string.localizable.configInquiresAboutTheApp())
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                        
                        Button(action: {
                            viewModel.openUrlString(string: ContactAbountAddCharacterUrlString)
                        }) {
                            Text(R.string.localizable.configInquiresAddingCharacters())
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                    }
                    
                    Section(header: Text(R.string.localizable.configApplicationInfo())) {
                        HStack {
                            Text(R.string.localizable.configVersionInfo())
                                .foregroundColor(Color(R.color.textColor.name))
                            Spacer()
                            Text(viewModel.versionString)
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                        Button {
                            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                return
                            }
                            UIApplication.shared.open(settingsUrl, completionHandler: nil)
                        } label: {
                            Text(R.string.localizable.configOther())
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                    }
                    
                    Section(header: Text(R.string.localizable.configReset())) {
                        Button(action: {
                            viewModel.resetButtonTapped()
                        }) {
                            Text(R.string.localizable.configReset())
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                        .alert(isPresented: $viewModel.showingResetAlert) {
                            Alert(
                                title: Text(R.string.localizable.configReset()),
                                message: Text(R.string.localizable.configAreYouSureYouWantToResetTheApp()),
                                primaryButton: .default(Text(R.string.localizable.commonCancel())) {
                                    print("リセットをキャンセルしました。")
                                }, secondaryButton: .destructive(Text(R.string.localizable.configReset())) {
                                    viewModel.withdraw()
                                })
                        }
                    }
                }.listStyle(GroupedListStyle())
                
                AdmobBannerView(adUnitID: environmentVariable.admobConfigUnitID)
            }
            .navigationBarTitle(R.string.localizable.configConfig(), displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(R.image.commonIconClose.name)
                                            .renderingMode(.template)
                                            .foregroundColor(Color( R.color.charalarmDefaultGray.name))
                                    }
            )
        }.onAppear {
            viewModel.fetchCharacter()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.setChara)) { _ in
            viewModel.fetchCharacter()
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text(R.string.localizable.commonClose())))
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
