import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct CharacterListView: View {
    @ObservedObject(initialValue: CharacterListViewModel()) var viewModel: CharacterListViewModel
    var body: some View {
        ZStack {
            List(viewModel.profiles) { profile in
                NavigationLink(destination: ProfileView(profile: profile)) {
                    HStack {
                        WebImage(url: URL(string: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic"))
                            .resizable()
                            .placeholder {
                                Image("profile")
                                    .resizable()
                                    .frame(width: 54, height: 54)
                        }
                            .animation(.easeInOut(duration: 0.5)) // Animation Duration
                            .transition(.fade) // Fade Transition
                            .scaledToFit()
                            .frame(width: 54.0, height: 54, alignment: .center)

                        Text(profile.name)
                    }.frame(height: 60)
                }
            }.listStyle(DefaultListStyle())

            VStack {
                Spacer()
                VStack {
                    HStack {
                        Text("PR")
                        Spacer()
                    }
                    Text("キャラクターを追加しませんか？？")

                }
                .background(Color.white)
            .border(Color.red, width: 2)
            }.padding()
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
