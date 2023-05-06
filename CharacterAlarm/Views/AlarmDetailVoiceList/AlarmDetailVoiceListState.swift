import SwiftUI
import AVFoundation

class AlarmDetailVoiceListState: ObservableObject {
    let chara: Chara
    var avPlayer: AVPlayer?
    var selectedCharaCall: CharaCall?
    
    init(chara: Chara) {
        self.chara = chara
    }
    
    func randomPlayAndSelecVoice() {
        selectedCharaCall = nil
        guard let randomCharaCall = chara.calls.randomElement(),
        let url = URL(string: randomCharaCall.voice) else {
            return
        }
        playVoice(url: url)
    }
    
    func playAndSelectVoice(charaCall: CharaCall) {
        selectedCharaCall = charaCall
        guard let url = URL(string: charaCall.voice) else {
            // TODO: エラーメッセージを表示
            return
        }
        playVoice(url: url)
    }
    
    private func playVoice(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        avPlayer = AVPlayer(playerItem: playerItem)
        avPlayer?.play()
    }
}
