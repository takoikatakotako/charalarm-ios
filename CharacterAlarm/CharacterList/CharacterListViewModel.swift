import SwiftUI

class CharacterListViewModel: ObservableObject {
    let model: CharacterListModel = CharacterListModel()
    @Published var characters: [Character] = []

    init() {
        model.featchCharacters(limit: 5) { (characters, _) in
            self.characters = characters
        }
    }

    func featchCharacters() {
        model.featchCharacters(limit: 5) { (characters, _) in
            self.characters = characters
        }
    }
}
