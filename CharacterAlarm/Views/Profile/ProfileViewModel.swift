import Foundation
import CallKit
import SwiftUI

class ProfileViewModel: ObservableObject {
    let charaDomain: String
    @Published var character: Character?
    @Published var showCallView: Bool = false
    @Published var showCallItem = false
    @Published var showCheckItem = false
    @Published var showSelectAlert = false
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    var charaThumbnailUrlString: String {
        return ResourceHandler.getCharaThumbnailUrlString(charaDomain: charaDomain)
    }
    
    init(charaDomain: String) {
        self.charaDomain = charaDomain
    }
    
    func fetchCharacter() {
        CharacterStore.fetchCharacter(charaDomain: charaDomain) { result in
            switch result {
            case let .success(character):
                self.character = character
            case let .failure(error):
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
    }
    
    func download() {
        ResourceStore.downloadSelfIntroduction(charaDomain: charaDomain) { result in
            switch result {
            case .success(_):
                print("自己紹介音声の保存に成功しました")
            case let .failure(error):
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
    }
    
    func selectCharacter() {
        guard
            let charaDomain = character?.charaDomain,
            let charaName = character?.name else {
            return
        }
        UserDefaultsHandler.setCharaDomain(charaDomain: charaDomain)
        UserDefaultsHandler.setCharaName(charaName: charaName)
        NotificationCenter.default.post(name: NSNotification.setChara,
                                                        object: nil, userInfo: nil)
    }
}
