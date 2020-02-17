import SwiftUI

struct ProfileIcon: View {
    var body: some View {
        Image("character-placeholder")
            .resizable()
            .scaledToFill()
            .clipped()
    }
}

struct ProfileRow: View {
    let title: String
    let text: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(Font.headline)
                    .foregroundColor(Color.gray)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                Text(text)
                    .foregroundColor(Color.gray)
                Divider()
            }
        }
            .padding(.horizontal, 16)
    }
}

struct ProfileView: View {
    let profile: Profile
    @EnvironmentObject var appState: AppState
    @ObservedObject(initialValue: ProfileViewModel()) var viewModel: ProfileViewModel
    @State var showCallItem = false
    @State var showCheckItem = false
    @State var showSelectAlert = false

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                ProfileIcon()
                ProfileRow(title: "名前\(self.appState.isCalling)", text: profile.name)
                ProfileRow(title: "プロフィール", text: profile.description)
                ProfileRow(title: "サークル名", text: profile.circleName)
                ProfileRow(title: "CV", text: profile.voiceName)
            }

            ZStack(alignment: .bottomTrailing) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    Spacer()
                    if showCallItem {
                        Button(action: {
                            self.viewModel.call()
                        }) {
                            MenuItem(imageName: "profile-call")
                        }
                    }
                    if showCheckItem {
                        Button(action: {
                            print("Check")
                            self.showSelectAlert = true

                        }) {
                            MenuItem(imageName: "profile-check")
                        }
                    }
                    Button(action: {
                        self.showMenu()
                    }) {
                        Group {
                            Image("profile-menu-icon")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }.accentColor(.white)
                            .frame(width: 80, height: 80)
                            .background(Color.black)
                            .cornerRadius(40)
                            .shadow(color: .black, radius: 4, x: 4, y: 4)
                            .opacity(0.9)
                    }
                }
                .padding()
            }.alert(isPresented: self.$showSelectAlert) {
            Alert(
                title: Text("キャラクター選択"),
                message: Text("このキャラクターに電話してもらいたいですか？"),
                primaryButton: .default(Text("閉じる")) {
                    print("ボタンその１")
                    // Close
                }, secondaryButton: .default(Text("はい！！")) {
                    // Select
                    print("ボタンその２")
                })
            }
        }
    }

    func showMenu() {
        withAnimation {
            self.showCheckItem.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showCallItem.toggle()
            }
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: Profile())
    }
}
