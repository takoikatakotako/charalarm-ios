import SwiftUI

struct CharacterListView: View {
    @ObservedObject(initialValue: CharacterListViewModel()) var viewModel: CharacterListViewModel
    var body: some View {
        List(viewModel.profiles) { profile in
            NavigationLink(destination: ProfileView(profile: profile)) {
                HStack {
                    Image("profile")
                        .resizable()
                        .frame(width: 54, height: 54)
                    Text(profile.name)
                }.frame(height: 60)
            }
        }.listStyle(DefaultListStyle())
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
