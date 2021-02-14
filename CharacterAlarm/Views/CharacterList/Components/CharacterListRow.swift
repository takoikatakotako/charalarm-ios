import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct CharacterListRow: View {
    let character: Character
    var body: some View {
        HStack {
            WebImage(url: URL(string: character.charaThumbnailUrlString))
                .resizable()
                .placeholder {
                    Image(R.image.characterPlaceholder.name)
                        .resizable()
            }
            .frame(width: 80, height: 80)
            .animation(.easeInOut(duration: 0.5))
            .transition(.fade)
            .scaledToFill()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(character.name)
                    .font(Font.system(size: 18.0))
                Text("\(R.string.localizable.characterIllustration()): \(character.illustrationName)")
                    .font(Font.system(size: 16.0))
                
                Text("\(R.string.localizable.characterVoice()): \(character.voiceName)")
                    .font(Font.system(size: 16.0))
            }
            
            Spacer()
        }
    }
}

//struct CharacterListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterListRow(character: Character(id: "com.charalarm.yui", name: "井上結衣"))
//            .previewLayout(.sizeThatFits)
//    }
//}
