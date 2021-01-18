//import UIKit
//import CallKit
//import AVFoundation
//
//protocol CallkitHandlerDelegate: AnyObject {
//    func callAnswer()
//    func callEnd()
//}
//
//class CallKitHandler: NSObject, CXProviderDelegate {
//    weak var delegate: CallkitHandlerDelegate?
//    var audioPlayer: AVAudioPlayer!
//
//    func providerDidReset(_ provider: CXProvider) {
//    }
//
//    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
//        print("@@@@@@@@@@@@@@@@@@@@@@")
//        print("AVAudioSession")
//        print("@@@@@@@@@@@@@@@@@@@@@@")
//
//        let audioname = "com_swiswiswift_inoue_yui_alarm_0"
//        if let sound = NSDataAsset(name: audioname) {
//            audioPlayer = try? AVAudioPlayer(data: sound.data)
//            audioPlayer?.play()
//        }
//    }
//
//    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
//        // 開始
//        delegate?.callAnswer()
//        action.fulfill()
//    }
//
//    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
//        // 終了
//        delegate?.callEnd()
//        action.fulfill()
//    }
//}
