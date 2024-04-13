import SwiftUI
import SDWebImageSwiftUI

struct ConfigView: View {
    @StateObject var viewState: ConfigViewState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                List {
                    Section(header: Text(R.string.localizable.configUserInfo())) {
                        NavigationLink(destination: UserInfoView(viewState: UserInfoViewState())) {
                            Text(R.string.localizable.configUserInfo())
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                    }

                    Section(header: Text(R.string.localizable.configPremiumPlan())) {
                        Button {
                            viewState.subscriptionButtonTapped()
                        } label: {
                            Text(R.string.localizable.configAboutPremiumPlan())
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                    }

                    Section(header: Text(R.string.localizable.configOther())) {
                        Button(action: {
                            viewState.openUrlString(string: OfficialDiscordUrlString)
                        }) {
                            Text(R.string.localizable.configOfficialDiscord())
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                        
                        Button(action: {
                            viewState.openUrlString(string: OfficialTwitterUrlString)
                        }) {
                            Text(R.string.localizable.configOfficialTwitter())
                                .foregroundColor(Color(R.color.textColor.name))
                        }

                        NavigationLink(destination: ContactView(viewState: ContactViewState())) {
                            Text("お問い合わせ")
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                    }

                    Section(header: Text(R.string.localizable.configApplicationInfo())) {
                        // バージョン情報
                        HStack {
                            Text(R.string.localizable.configVersionInfo())
                                .foregroundColor(Color(R.color.textColor.name))
                            Spacer()
                            Text(viewState.versionString)
                                .foregroundColor(Color(R.color.textColor.name))
                        }

                        // ライセンス
                        NavigationLink {
                            LicenceView(viewState: LicenceViewState())
                        } label: {
                            Text(R.string.localizable.configLicense())
                        }

                        // その他
                        Button {
                            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                return
                            }
                            UIApplication.shared.open(settingsUrl, completionHandler: nil)
                        } label: {
                            Text(R.string.localizable.configOtherAppSetting())
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                    }

                    Section(header: Text(R.string.localizable.configReset())) {
                        Button(action: {
                            viewState.resetButtonTapped()
                        }) {
                            Text(R.string.localizable.configReset())
                                .foregroundColor(Color(R.color.textColor.name))
                        }
                        .alert(isPresented: $viewState.showingResetAlert) {
                            Alert(
                                title: Text(R.string.localizable.configReset()),
                                message: Text(R.string.localizable.configAreYouSureYouWantToResetTheApp()),
                                primaryButton: .default(Text(R.string.localizable.commonCancel())) {
                                    // ResetCancel
                                }, secondaryButton: .destructive(Text(R.string.localizable.configReset())) {
                                    viewState.withdraw()
                                })
                        }
                    }

                    // 広告とリセットせるが被ってしまうのでパディング追加のため
                    // もっと良い方法があれば修正したい
                    Section("") {}
                }
                .listStyle(GroupedListStyle())

                if viewState.isShowingADs {
                    AdmobBannerView(adUnitID: EnvironmentVariableConfig.admobConfigUnitID)
                }
            }
            .navigationBarTitle(R.string.localizable.configConfig(), displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(R.image.commonIconClose.name)
                            .renderingMode(.template)
                            .foregroundColor(Color( R.color.charalarmDefaultGray.name))
                    }
            )
        }
        .fullScreenCover(isPresented: $viewState.showingSubscriptionSheet, content: {
            SubscriptionView(viewState: SubscriptionViewState())
        })
        .alert(isPresented: $viewState.showingAlert) {
            Alert(title: Text(""), message: Text(viewState.alertMessage), dismissButton: .default(Text(R.string.localizable.commonClose())))
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView(viewState: ConfigViewState())
    }
}
