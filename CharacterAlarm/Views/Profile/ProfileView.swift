import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    let characterId: String
    @ObservedObject(initialValue: ProfileViewModel()) var viewModel: ProfileViewModel
    
    var character: Character? {
        return self.viewModel.character
    }
    
    var body: some View {
        GeometryReader { geometory in
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    WebImage(url: URL(string: "https://charalarm.com/image/\(self.characterId)/thumbnail.png"))
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
                        if self.viewModel.showCallItem {
                            Button(action: {
                                self.viewModel.showCallView = true
                            }) {
                                MenuItem(imageName: "profile-call")
                            }.sheet(isPresented: self.$viewModel.showCallView) {
                                CallView(characterId: self.characterId, characterName: self.character?.name ?? "loading")
                            }
                        }
                        if self.viewModel.showCheckItem {
                            Button(action: {
                                print("Check")
                                self.viewModel.showSelectAlert = true
                                
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
                }
            }
        }.onAppear {
            self.viewModel.fetchCharacter(characterId: self.characterId)
            self.viewModel.download(characterId: self.characterId)
        }.alert(isPresented: self.$viewModel.showSelectAlert) {
            Alert(
                title: Text("キャラクター選択"),
                message: Text("このキャラクターに電話してもらいたいですか？"),
                primaryButton: .default(Text("閉じる")) {
                    print("ボタンその１")
                    // Close
                }, secondaryButton: .default(Text("はい！！")) {
                    // Select
                    print("ボタンその２")
                    self.viewModel.selectCharacter()
                    //                            self.appState.characterId = self.profile.characterId
                })
        }
    }
    
    func showMenu() {
        withAnimation {
            self.viewModel.showCheckItem.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.viewModel.showCallItem.toggle()
            }
        })
    }
    
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(profile: Profile())
//    }
//}
