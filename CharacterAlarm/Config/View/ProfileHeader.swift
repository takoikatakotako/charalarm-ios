import SwiftUI

struct ProfileHeader: View {
    var body: some View {
        HStack {
            Image("profile")
                .resizable()
                .frame(width: 76, height: 76, alignment: .center)
                .clipShape(Circle())
            VStack (alignment: .leading) {
                Text("井上結衣")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 24))
                Text("旋風鬼")
                .foregroundColor(.gray)
                    .font(Font.system(size: 18))
                    .padding(.top, 8)
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
