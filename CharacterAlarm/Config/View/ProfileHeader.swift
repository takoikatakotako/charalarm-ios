import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage

struct ProfileHeader: View {
    let characterId: String
    @State var urlString: String = ""
    @State var characterName: String = ""
    @State var circleName: String = ""

    var body: some View {
        HStack {
            WebImage(url: URL(string: self.urlString))
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
            .onAppear {
                self.featchImageUrl()
                self.featchProfile()
            }

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

    func featchImageUrl() {
        let storage = Storage.storage()
        let pathReference = storage.reference(withPath: "character/\(self.characterId)/profile.png")
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

    func featchProfile() {
        ProfileStore.featchProfile(characterId: characterId) { (profile, _) in
            guard let profile = profile else {
                return
            }
            self.characterName = profile.name
            self.circleName = profile.circleName
        }
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader(characterId: "xxxxxxxxx")
            .previewLayout(.fixed(width: 300, height: 80))
    }
}
