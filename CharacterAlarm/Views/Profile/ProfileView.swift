import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage

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
    let characterId: String
    @EnvironmentObject var appState: AppState
    @ObservedObject(initialValue: ProfileViewModel()) var viewModel: ProfileViewModel
    @State var showCallItem = false
    @State var showCheckItem = false
    @State var showSelectAlert = false
    
    var character: Character2? {
        return self.viewModel.character
    }
    
    var body: some View {
        GeometryReader { geometory in
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    WebImage(url: URL(string: "https://charalarm.com/image/\(self.characterId)/thumbnail_list.png"))
                        .resizable()
                        .placeholder {
                            Image("character-placeholder")
                                .resizable()
                    }
                    .animation(.easeInOut(duration: 0.5))
                    .transition(.fade)
                    .frame(width: geometory.size.width, height: geometory.size.width)
                    .scaledToFill()
                    
                    ProfileRow(title: "名前", text: self.character?.name ?? "")
                    ProfileRow(title: "プロフィール", text: self.character?.name ?? "")
                    ProfileRow(title: "サークル名", text: self.character?.name ?? "")
                    ProfileRow(title: "CV", text: self.character?.name ?? "")
                }
                
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack {
                        Spacer()
                        if self.showCallItem {
                            Button(action: {
                                self.viewModel.showCallView = true
                            }) {
                                MenuItem(imageName: "profile-call")
                            }.sheet(isPresented: self.$viewModel.showCallView) {
                                CallView(characterId: self.characterId, characterName: self.character?.name ?? "loading")
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
                            //                            self.appState.characterId = self.profile.characterId
                        })
                }
            }
        }.onAppear {
            self.viewModel.fetchCharacter(characterId: self.characterId)
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

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(profile: Profile())
//    }
//}
