import SwiftUI
import AVFoundation

class AlarmVoiceListViewModel: ObservableObject {
    let chara: Character
    var avPlayer: AVPlayer?
    
    init(chara: Character) {
        self.chara = chara
    }
    
    func playVoice(filePath: String) {
        let urlString = "http://localhost:4566/charalarm-image\(filePath)"
        
        let url = URL(string: urlString)!
        let playerItem = AVPlayerItem(url: url)
        avPlayer = AVPlayer(playerItem: playerItem)
        avPlayer?.play()
    }
    
    func randomPlayVoice() {
        
    }

    
}
