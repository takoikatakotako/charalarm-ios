import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct Pokemon: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct PokemonView: View {
    let pokemon: Pokemon
    var body: some View {
        ZStack {
            Image(pokemon.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack {
                Spacer()
                Text(pokemon.name)
                    .font(Font.system(size: 20.0).bold())
                    .frame(maxWidth: .infinity, maxHeight: 32)
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    .opacity(0.8)
            }
        }
    }
}

struct CharacterListView: View {
    @ObservedObject(initialValue: CharacterListViewModel()) var viewModel: CharacterListViewModel

    let columns: Int = 3
    let pokemons = [
        Pokemon(name: "カビゴン", imageName: "snorlax"),
        Pokemon(name: "ゲンガー", imageName: "gengar"),
        Pokemon(name: "ヌオー", imageName: "quagsire"),
        Pokemon(name: "コイル", imageName: "magnemite"),
        Pokemon(name: "ミニリュウ", imageName: "dratini"),
        Pokemon(name: "ヤドン", imageName: "slowpoke"),
        Pokemon(name: "コダック", imageName: "psyduck")
    ]
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                ForEach(0..<self.pokemons.count/self.columns) { rowIndex in
                    HStack {
                        ForEach(0..<self.columns) { columnIndex in
                            PokemonView(pokemon: self.pokemons[self.columns * rowIndex + columnIndex])
                                .frame(width: self.cellWidth(width: geometry.size.width),
                                       height: self.cellHeight(width: geometry.size.width))
                                .border(Color.black, width: 2)
                                .clipped()
                        }
                    }
                }

                if (self.pokemons.count % self.columns > 0) {
                    HStack {
                        ForEach(0..<self.pokemons.count % self.columns) { column in
                            PokemonView(pokemon: self.pokemons[self.columns * (self.pokemons.count / self.columns) + column])
                                .frame(width: self.cellWidth(width: geometry.size.width),
                                       height: self.cellHeight(width: geometry.size.width))
                                .border(Color.black, width: 2)
                                .clipped()
                        }
                        Spacer()
                    }
                }
            }
        }.padding()
    }

    private func cellWidth(width: CGFloat) -> CGFloat {
        return width / CGFloat(columns)
    }

    private func cellHeight(width: CGFloat) -> CGFloat {
        return cellWidth(width: width) * 1.5
    }

}

//WebImage(url: URL(string: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic"))
//    .resizable()
//    .placeholder {
//        Image("profile")
//            .resizable()
//            .frame(width: 54, height: 54)
//}
//    .animation(.easeInOut(duration: 0.5)) // Animation Duration
//    .transition(.fade) // Fade Transition
//    .scaledToFit()
//    .frame(width: 54.0, height: 54, alignment: .center)

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
