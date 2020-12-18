import SwiftUI
import UIKit
import AVFoundation

class CallViewModel: ObservableObject {
    let charaDomain: String
    let charaName: String
    
    var incomingAudioPlayer: AVAudioPlayer!
    var voiceAudioPlayer: AVAudioPlayer!
    @Published var overlay = true
    
    var charaThumbnailUrlString: String {
        return ResourceHandler.getCharaThumbnailUrlString(charaDomain: charaDomain)
    }
    
    init(charaDomain: String, charaName: String) {
        self.charaDomain = charaDomain
        self.charaName = charaName
    }
    
    func call() {
        incomingAudioPlayer?.setVolume(0, fadeDuration: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ResourceStore.loadSelfIntroductionData(charaDomain: self.charaDomain) { result in
                switch result {
                case let .success(data):
                    self.voiceAudioPlayer = try? AVAudioPlayer(data: data)
                    self.voiceAudioPlayer?.play()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func incoming() {
        if let sound = NSDataAsset(name: "ringtone") {
            incomingAudioPlayer = try? AVAudioPlayer(data: sound.data)
            incomingAudioPlayer?.play()
        }
    }
    
    func fadeOut() {
        self.incomingAudioPlayer?.setVolume(0.0, fadeDuration: 0.5)
        self.voiceAudioPlayer?.setVolume(0.0, fadeDuration: 0.5)
    }
}
