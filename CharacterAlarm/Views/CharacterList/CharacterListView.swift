import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct CharacterListView: View {
    @ObservedObject(initialValue: CharacterListViewModel()) var viewModel: CharacterListViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                List(viewModel.characters) { character in
                    NavigationLink(destination: ProfileView(characterId: character.id)) {
                        CharacterListRow(character: character)
                            .frame(height: 80)
                            .clipped()
                    }
                }
                Spacer()
            }
            
            Button(action: {
                print("xxx")
            }) {
                CharacterListBanner()
                    .padding(.bottom, 36)
            }
        }
        .onAppear {
            self.viewModel.fetchCharacters()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
