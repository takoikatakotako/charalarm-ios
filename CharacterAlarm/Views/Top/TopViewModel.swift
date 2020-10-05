import SwiftUI
import AVFoundation

class TopViewModel: ObservableObject {
    @Published var showNews: Bool = false
    @Published var showConfig: Bool = false
    @Published var showingAlert: Bool = false
    @Published var alertMessage: String = ""
    var audioPlayer: AVAudioPlayer!
    
    func tapped() {
        if let sound = NSDataAsset(name: "com_swiswiswift_inoue_yui_alarm_0") {
            audioPlayer = try? AVAudioPlayer(data: sound.data)
            audioPlayer?.play() // → これで音が鳴る
        }
    }
    
    func featchCharacter(charaDomain: String, completion: @escaping (Character) -> Void) {
        CharacterStore.fetchCharacter(charaDomain: charaDomain) { result in
            switch result {
            case let .success(character):
                completion(character)
            case let .failure(error):
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
    }
}
