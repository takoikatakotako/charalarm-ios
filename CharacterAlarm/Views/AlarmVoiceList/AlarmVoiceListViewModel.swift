import SwiftUI
import AVFoundation

class AlarmVoiceListViewModel: ObservableObject {
    var avPlayer: AVPlayer?

    func playVoice(filePath: String) {
        let urlString = "http://localhost:4566/charalarm-image\(filePath)"
        
        let url = URL(string: urlString)!
        let playerItem = AVPlayerItem(url: url)
        avPlayer = AVPlayer(playerItem: playerItem)
        avPlayer?.play()
    }
}
