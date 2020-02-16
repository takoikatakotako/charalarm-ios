import UIKit
import CallKit
import AVFoundation

class CallkitHandler: NSObject, CXProviderDelegate {
    var audioPlayer: AVAudioPlayer!

    func providerDidReset(_ provider: CXProvider) {
    }

    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        print("@@@@@@@@@@@@@@@@@@@@@@")
        print("AVAudioSession")
        print("@@@@@@@@@@@@@@@@@@@@@@")

        let audioname = "com_swiswiswift_inoue_yui_alarm_0"
        if let sound = NSDataAsset(name: audioname) {
            audioPlayer = try? AVAudioPlayer(data: sound.data)
            audioPlayer?.play()
        }
    }

    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        // 開始
        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        // 終了
        action.fulfill()
    }
}
