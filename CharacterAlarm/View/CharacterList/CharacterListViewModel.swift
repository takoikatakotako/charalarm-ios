import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published var charaList: [Chara] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    let apiRepository: APIRepository = APIRepository()
    let openURLRepository: OpenURLRepository = OpenURLRepository()
    
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
    
    func characterAddRequestTapped() {
        let url = openURLRepository.characterAdditionRequestURL
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
