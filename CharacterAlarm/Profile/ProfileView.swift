import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage

struct ProfileIcon: View {
    let profile: Profile
    @State var urlString: String = ""
    var body: some View {
        WebImage(url: URL(string: self.urlString))
            .resizable()
            .placeholder {
                Image("character-placeholder")
                    .resizable()
        }
        .animation(.easeInOut(duration: 0.5))
        .transition(.fade)
        .scaledToFill()
        .onAppear {
            self.featchImageUrl()
        }
    }

    func featchImageUrl() {
        let storage = Storage.storage()
        let pathReference = storage.reference(withPath: "character/\(profile.id)/profile.png")
        pathReference.downloadURL { url, error in
            if let error = error {
                // Handle any errors
                print(error)
            } else {
                guard let urlString = url?.absoluteString else {
                    return
                }
                self.urlString = urlString
            }
        }
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
        GeometryReader { geometory in
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ProfileIcon(profile: self.profile)
                        .frame(width: geometory.size.width, height: geometory.size.width)
                    ProfileRow(title: "名前\(self.appState.isCalling)", text: self.profile.name)
                    ProfileRow(title: "プロフィール", text: self.profile.description)
                    ProfileRow(title: "サークル名", text: self.profile.circleName)
                    ProfileRow(title: "CV", text: self.profile.voiceName)
                }

                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack {
                        Spacer()
                        if self.showCallItem {
                            Button(action: {
                                self.viewModel.call()
                            }) {
                                MenuItem(imageName: "profile-call")
                            }
                        }
                        if self.showCheckItem {
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
                            self.appState.characterId = self.profile.characterId
                        })
                }
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
