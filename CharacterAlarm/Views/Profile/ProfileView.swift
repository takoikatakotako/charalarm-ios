import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage

struct ProfileIcon: View {

    let characterId: String
    var body: some View {
        WebImage(url: URL(string: "https://charalarm.com/image/\(characterId)/thumbnail_list.png"))
            .resizable()
            .placeholder {
                Image("character-placeholder")
                    .resizable()
        }
        .animation(.easeInOut(duration: 0.5))
        .transition(.fade)
        .scaledToFill()
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
    let characterId: String
    @EnvironmentObject var appState: AppState
    @ObservedObject(initialValue: ProfileViewModel()) var viewModel: ProfileViewModel
    @State var showCallItem = false
    @State var showCheckItem = false
    @State var showSelectAlert = false

    
    @State var character: Character2?
    
    var body: some View {
        GeometryReader { geometory in
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ProfileIcon(characterId: self.characterId)
                        .frame(width: geometory.size.width, height: geometory.size.width)
                    
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
//                            self.appState.characterId = self.profile.characterId
                        })
                }
            }
        }.onAppear {
            self.fetchCharacter()
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
    
    
    func fetchCharacter() {
          let url = URL(string: "https://charalarm.com/api/\(characterId)/character.json")!
          
          let task = URLSession.shared.dataTask(with: url) { data, response, error in
              
              // ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
              if let error = error {
                  print("クライアントサイドエラー: \(error.localizedDescription) \n")
                  return
              }
              
              guard let data = data, let response = response as? HTTPURLResponse else {
                  print("no data or no response")
                  return
              }
              
              if response.statusCode == 200 {
                  print(data)
                  
                  guard let character = try? JSONDecoder().decode(Character2.self, from: data) else {
                      print("パース失敗")
                      return
                  }
                  
                  DispatchQueue.main.async {
                      self.character = character
                      
                  }
                  // ...これ以降decode処理などを行い、UIのUpdateをメインスレッドで行う
                  
              } else {
                  // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                  print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
              }
              
          }
          task.resume()
      }
    
    
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(profile: Profile())
//    }
//}
