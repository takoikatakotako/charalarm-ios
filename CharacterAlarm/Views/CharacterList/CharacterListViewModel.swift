import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    let charaRepository: CharaRepository = CharaRepository()
    
    func fetchCharacters() {
        Task { @MainActor in
            do {
                let characters = try await charaRepository.fetchCharacters()
                self.characters = characters
            } catch {
                self.alertMessage = R.string.localizable.characterFailedToGetTheCharacter()
                self.showingAlert = true
            }
        }
    }
}
