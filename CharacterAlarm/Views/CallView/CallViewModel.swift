import SwiftUI
import UIKit
import AVFoundation

class CallViewModel: ObservableObject {

    var incomingAudioPlayer: AVAudioPlayer!
    var voiceAudioPlayer: AVAudioPlayer!

    func call() {
        incomingAudioPlayer?.setVolume(0, fadeDuration: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let sound = NSDataAsset(name: "com_swiswiswift_inoue_yui_alarm_0") {
                self.voiceAudioPlayer = try? AVAudioPlayer(data: sound.data)
                self.voiceAudioPlayer?.play()
            }
        }
    }
    
    func incoming() {
        if let sound = NSDataAsset(name: "harunouta") {
            incomingAudioPlayer = try? AVAudioPlayer(data: sound.data)
            incomingAudioPlayer?.play()
        }
    }
}
