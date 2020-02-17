import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage

struct ProfileHeader: View {
    let profile: Profile
    let characterName: String
    let circleName: String
    @State var urlString: String = ""

    init() {
        self.profile = Profile()
        self.characterName = ""
        self.circleName = ""
    }

    init(profile: Profile) {
        self.profile = profile
        self.characterName = profile.name
        self.circleName = profile.circleName
    }

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
        let pathReference = storage.reference(withPath: "character/\(profile.id)/profile.png")
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
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader()
            .previewLayout(.fixed(width: 300, height: 80))
    }
}
