import SwiftUI
import UIKit
import AVFoundation

class CallViewModel: ObservableObject {
    
    var incomingAudioPlayer: AVAudioPlayer!
    var voiceAudioPlayer: AVAudioPlayer!
    
    func call() {
        incomingAudioPlayer?.setVolume(0, fadeDuration: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            guard let data = try? FileHandler.readNoteJSON(directoryName: "characterId", fileName: "sample.caf") else {
                return
            }
            
            self.voiceAudioPlayer = try? AVAudioPlayer(data: data)
            self.voiceAudioPlayer?.play()
        }
    }
    
    func incoming() {
        if let sound = NSDataAsset(name: "harunouta") {
            incomingAudioPlayer = try? AVAudioPlayer(data: sound.data)
            incomingAudioPlayer?.play()
        }
    }
}
