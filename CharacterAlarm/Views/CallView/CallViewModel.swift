import SwiftUI
import UIKit
import AVFoundation

class CallViewModel: ObservableObject {
    let charaDomain: String
    let charaName: String
        
    @Published var overlay = true
    
    var charaThumbnailUrlString: String {
        return charalarmEnvironment.resourceHandler.getCharaThumbnailUrlString(charaDomain: charaDomain)
    }
    
    init(charaDomain: String, charaName: String) {
        self.charaDomain = charaDomain
        self.charaName = charaName
    }
}
