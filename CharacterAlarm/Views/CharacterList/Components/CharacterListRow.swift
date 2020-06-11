import SwiftUI
import UIKit
import SDWebImageSwiftUI
import FirebaseStorage

struct CharacterListRow: View {
    let character: Character2
      @State var urlString: String = ""
      var body: some View {
          ZStack {
            WebImage(url: URL(string: "https://charalarm.com/image/\(character.id)/thumbnail_list.png"))
                  .resizable()
                  .placeholder {
                      Image("character-placeholder")
                          .resizable()
              }
              .animation(.easeInOut(duration: 0.5))
              .transition(.fade)
              .scaledToFill()

              VStack {
                  Spacer()
                  Text(character.name)
                      .font(Font.system(size: 20.0).bold())
                      .frame(maxWidth: .infinity, maxHeight: 32)
                      .background(Color.gray)
                      .foregroundColor(Color.white)
                      .opacity(0.8)
              }
          }
      }
}

struct CharacterListRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListRow(character: Character2(id: "com.swiswiswift.charalarm.yui", name: "井上結衣"))
    }
}
