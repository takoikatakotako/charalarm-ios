import SwiftUI

struct CharacterList: View {
    var body: some View {
        List {

            NavigationLink(destination: ProfileView()) {
                HStack {
                    Image("profile")
                        .resizable()
                        .frame(width: 54, height: 54)
                    Text("井上結衣")
                }.frame(height: 60)
            }

            NavigationLink(destination: ProfileView()) {
                HStack {
                    Image("profile")
                        .resizable()
                        .frame(width: 54, height: 54)
                    Text("旋風鬼鬼子")
                }.frame(height: 60)
            }
        }.listStyle(DefaultListStyle())
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
    }
}
