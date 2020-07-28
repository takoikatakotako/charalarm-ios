import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func fetchCharacters() {
        CharacterStore.fetchCharacters { error, characters in
            if let error = error {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = error.localizedDescription
                }
                return
            }
            DispatchQueue.main.async {
                self.characters = characters
            }
        }
    }
}
