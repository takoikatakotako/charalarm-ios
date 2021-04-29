import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    let charaRepository: CharaRepository = CharaRepository()
    
    func fetchCharacters() {
        charaRepository.fetchCharacters { result in
            switch result {
            case let .success(characters):
                self.characters = characters
            case .failure:
                self.alertMessage = R.string.localizable.characterFailedToGetTheCharacter()
                self.showingAlert = true
            }
        }
    }
}
