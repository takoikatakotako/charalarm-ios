import SwiftUI

class CharacterListViewModel: ObservableObject {
    let model: CharacterListModel = CharacterListModel()
    @Published var profiles: [Profile] = []

    init() {
        model.featchProfiles(limit: 5) { (profiles, _) in
            self.profiles = profiles
        }
    }
}
