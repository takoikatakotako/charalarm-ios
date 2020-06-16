import SwiftUI
import UIKit
import AVFoundation

class CallViewModel: ObservableObject {

    var audioPlayer: AVAudioPlayer!

    func call() {
        if let sound = NSDataAsset(name: "com_swiswiswift_inoue_yui_alarm_0") {
            audioPlayer = try? AVAudioPlayer(data: sound.data)
            audioPlayer?.play() // → これで音が鳴る
        }
    }
    
    func arrive() {
        if let sound = NSDataAsset(name: "harunouta") {
            audioPlayer = try? AVAudioPlayer(data: sound.data)
            audioPlayer?.play() // → これで音が鳴る
        }
    }
}
