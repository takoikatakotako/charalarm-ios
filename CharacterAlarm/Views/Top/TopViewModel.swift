import SwiftUI
import AVFoundation

class TopViewModel: ObservableObject {
    @Published var showNews: Bool = false
    @Published var showConfig: Bool = false
    var audioPlayer: AVAudioPlayer!
}
