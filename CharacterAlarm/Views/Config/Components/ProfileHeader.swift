import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage

struct ProfileHeader: View {
    let imageUrlString: String
    let characterName: String
    let circleName: String

    var body: some View {
        HStack {
            WebImage(url: URL(string: self.imageUrlString))
                .resizable()
                .placeholder {
                    Image("character-placeholder")
                        .resizable()
            }
            .animation(.easeInOut(duration: 0.5))
            .transition(.fade)
            .scaledToFill()
            .frame(width: 76, height: 76, alignment: .center)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(self.characterName)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 24))
                Text(self.circleName)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 18))
                    .padding(.top, 8)
            }
        }
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader(imageUrlString: "https://via.placeholder.com/150x150", characterName: "井上結衣", circleName: "旋風鬼")
            .previewLayout(.sizeThatFits)
    }
}
