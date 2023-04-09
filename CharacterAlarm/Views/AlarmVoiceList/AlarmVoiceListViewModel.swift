import SwiftUI
import AVFoundation

class AlarmVoiceListViewModel: ObservableObject {
    let chara: Chara
    var avPlayer: AVPlayer?
    
    init(chara: Chara) {
        self.chara = chara
    }
    
    func playVoice(fileName: String) {
        let urlString = RESOURCE_ENDPOINT + fileName
        guard let url = URL(string: urlString) else {
            // TODO: ここでなんか投げる
            return
        }
        let playerItem = AVPlayerItem(url: url)
        avPlayer = AVPlayer(playerItem: playerItem)
        avPlayer?.play()
    }
    
    func playRandomVoice() {
//        guard let charaCall = chara.charaCallResponseEntities.randomElement() else {
//            return
//        }
//        playVoice(filePath: charaCall.charaFilePath)
    }
}
