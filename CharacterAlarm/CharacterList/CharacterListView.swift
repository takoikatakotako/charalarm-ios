import SwiftUI
import UIKit
import SDWebImageSwiftUI
import QGrid

struct CharacterListView: View {
    @ObservedObject(initialValue: CharacterListViewModel()) var viewModel: CharacterListViewModel

    var body: some View {
        ZStack {
            QGrid(viewModel.profiles, columns: 3) { profile in
                GridCell(profile: profile)
            }
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

struct GridCell: View {
    let profile: Profile
    var body: some View {
        ZStack {
            Image("profile")
                .resizable()
                .frame(width: 100, height: 160, alignment: .center)
                .scaledToFit()

            Text("person.firstName").lineLimit(1)
        }
    }
}

//WebImage(url: URL(string: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic"))
//    .resizable()
//    .placeholder {
//        Image("profile")
//            .resizable()
//            .frame(width: 54, height: 54)
//}
//    .animation(.easeInOut(duration: 0.5)) // Animation Duration
//    .transition(.fade) // Fade Transition
//    .scaledToFit()
//    .frame(width: 54.0, height: 54, alignment: .center)

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
