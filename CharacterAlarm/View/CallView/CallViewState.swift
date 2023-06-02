import SwiftUI
import UIKit
import AVFoundation

class CallViewState: ObservableObject {
    let charaDomain: String
    let charaName: String
    let resourceHandler = ResourceRepository()
        
    @Published var overlay = true
    
    
    var charaThumbnailUrlString: String {
        return resourceHandler.getCharaThumbnailUrlString(charaDomain: charaDomain)
    }
    
    init(charaDomain: String, charaName: String) {
        self.charaDomain = charaDomain
        self.charaName = charaName
    }
}
