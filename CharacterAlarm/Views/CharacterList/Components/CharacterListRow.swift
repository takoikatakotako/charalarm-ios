import SwiftUI
import UIKit
import SDWebImageSwiftUI
import FirebaseStorage

struct CharacterListRow: View {
    let character: Character
    @State var urlString: String = ""
    var body: some View {
        HStack {
            WebImage(url: URL(string: "https://charalarm.com/image/\(character.id)/thumbnail.png"))
                .resizable()
                .placeholder {
                    Image("character-placeholder")
                        .resizable()
            }
            .frame(width: 80, height: 80)
            .animation(.easeInOut(duration: 0.5))
            .transition(.fade)
            .scaledToFill()
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(Font.system(size: 18.0))
                
                Text("旋風鬼")
                    .font(Font.system(size: 16.0))
                
                Text("イラスト: 伊藤ライフ")
                    .font(Font.system(size: 16.0))
                
                Text("CV: おのじゅん")
                    .font(Font.system(size: 16.0))
            }
            
            
            Spacer()
        }
    }
}

struct CharacterListRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListRow(character: Character(id: "com.charalarm.yui", name: "井上結衣"))
            .previewLayout(.sizeThatFits)
    }
}
