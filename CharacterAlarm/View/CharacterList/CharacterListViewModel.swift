import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published var charaList: [Chara] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    let apiRepository: APIRepository = APIRepository()
    
    func fetchCharacters() {
        Task { @MainActor in
            do {
                self.charaList = try await apiRepository.getCharaList()
            } catch {
                alertMessage = R.string.localizable.characterFailedToGetTheCharacter()
                self.showingAlert = true
            }
        }
    }
}
