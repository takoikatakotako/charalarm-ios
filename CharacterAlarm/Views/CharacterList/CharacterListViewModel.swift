import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published var charaList: [Chara] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    let charaRepository: CharaRepository = CharaRepository()
    
    func fetchCharacters() {
        Task { @MainActor in
            do {
                self.charaList = try await charaRepository.fetchCharacters()
            } catch {
                alertMessage = R.string.localizable.characterFailedToGetTheCharacter()
                self.showingAlert = true
            }
        }
    }
}
