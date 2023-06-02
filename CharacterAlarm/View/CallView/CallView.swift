import SwiftUI
import UIKit
import SDWebImageSwiftUI
import AVFoundation

struct CallView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let charaDomain: String
    let charaName: String
    @State var incomingAudioPlayer: AVAudioPlayer?
    @State var voiceAudioPlayer: AVPlayer?
    @State var overlay = true
    
    let resourceHandler = ResourceRepository()
    
    
    @StateObject var viewState: CallViewState
    

    var body: some View {
        ZStack {
            VStack {
                WebImage(url: URL(string: viewState.charaThumbnailUrlString))
                    .resizable()
                    .placeholder {
                        Image(R.image.characterPlaceholder.name)
                            .resizable()
                }
                .animation(.easeInOut(duration: 0.5))
                .transition(.fade)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .scaledToFill()
                
                Text(charaName)
                    .font(Font.system(size: 40))
                    .foregroundColor(Color.black)
                    .padding(.top, 40)
                Spacer()
                
                Button(action: {
                    self.fadeOut()
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "phone.fill.arrow.down.left")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 40, height: 40)
                }
                    .frame(width: 80, height: 80)
                .background(Color(R.color.callRed.name))
                    .cornerRadius(40)
            }                    .padding(.bottom, 60)
            
            
            if overlay {
                VStack {
                    Text(charaName)
                        .font(Font.system(size: 40))
                        .foregroundColor(Color.white)
                        .padding(.top, 100)
                    Spacer()
                    
                    HStack(spacing: 160) {
                        Button(action: {
                            self.fadeOut()
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            
                            Image(systemName: "phone.fill.arrow.down.left")
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 40, height: 40)
                        }
                        .frame(width: 80, height: 80)
                        .background(Color(R.color.callRed.name))
                        .cornerRadius(40)
                        
                        
                        Button(action: {
                            self.call()
                            withAnimation {
                                self.overlay = false
                            }
                        }){
                            Image(systemName: "phone.fill")
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 40, height: 40)
                        }
                        .frame(width: 80, height: 80)
                        .background(Color(R.color.callGreen.name))
                        .cornerRadius(40)
                        
                    }
                    .padding(.bottom, 60)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            incoming()
        }
    }
    
    func call() {
        incomingAudioPlayer?.setVolume(0, fadeDuration: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {  
            let urlString = resourceHandler.getSelfIntroductionUrlString(charaDomain: charaDomain)
            let url = URL(string: urlString)!
            let playerItem = AVPlayerItem(url: url)
            voiceAudioPlayer = AVPlayer(playerItem: playerItem)
            voiceAudioPlayer?.play()
        }
    }
        
    func incoming() {
        if let sound = NSDataAsset(name: "ringtone") {
            incomingAudioPlayer = try? AVAudioPlayer(data: sound.data)
            incomingAudioPlayer?.volume = 0.3
            incomingAudioPlayer?.play()
            incomingAudioPlayer?.setVolume(1.0, fadeDuration: 0.5)
        }
    }
    
    func fadeOut() {
        self.incomingAudioPlayer?.setVolume(0.0, fadeDuration: 0.5)
        self.voiceAudioPlayer?.volume = 0
    }
}

struct CallView_Previews: PreviewProvider {
    static var previews: some View {
        CallView(charaDomain: "com.charalarm.yui", charaName: "井上結衣", viewState: CallViewState(charaDomain: "com.charalarm.yui", charaName: "井上結衣"))
    }
}
