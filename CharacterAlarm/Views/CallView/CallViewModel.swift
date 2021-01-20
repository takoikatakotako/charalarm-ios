import SwiftUI
import UIKit
import AVFoundation

class CallViewModel: ObservableObject {
    let charaDomain: String
    let charaName: String
    

    
    var xxxx: AVAudioPlayer?
    
    @Published var overlay = true
    
    var charaThumbnailUrlString: String {
        return ResourceHandler.getCharaThumbnailUrlString(charaDomain: charaDomain)
    }
    
    init(charaDomain: String, charaName: String) {
        self.charaDomain = charaDomain
        self.charaName = charaName
    }
    
}
