import SwiftUI
import AVFoundation

class TopViewModel: ObservableObject {
    @Published var showNews: Bool = false
    @Published var showConfig: Bool = false
    var audioPlayer: AVAudioPlayer!
    
    func tapped() {
        if let sound = NSDataAsset(name: "com_swiswiswift_inoue_yui_alarm_0") {
            audioPlayer = try? AVAudioPlayer(data: sound.data)
            audioPlayer?.play() // → これで音が鳴る
        }
    }
}
