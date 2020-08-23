import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct CharacterListView: View {
    @ObservedObject(initialValue: CharacterListViewModel()) var viewModel: CharacterListViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                List(viewModel.characters) { character in
                    NavigationLink(destination: ProfileView(characterId: character.charaDomain)) {
                        CharacterListRow(character: character)
                            .frame(height: 80)
                            .clipped()
                    }
                }
                Spacer()
            }
            
            Button(action: {
                print("キャラクター追加のお問い合わせ")
            }) {
                CharacterListBanner()
                    .padding(.bottom, 36)
            }
        }
        .onAppear {
            self.viewModel.fetchCharacters()
        }.alert(isPresented: self.$viewModel.showingAlert) {
            Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
