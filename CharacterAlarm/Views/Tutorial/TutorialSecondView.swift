import SwiftUI
import AVFoundation

struct TutorialSecondView: View {
    @EnvironmentObject var appState: CharalarmAppState

    @State private var isCalling = true
    @State private var showingNextButton = false
    @State private var incomingAudioPlayer: AVAudioPlayer!
    @State private var voiceAudioPlayer: AVAudioPlayer!
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                Image(R.image.tutorialNormal.name)
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 60)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            
            if isCalling {
                VStack {
                    Text("井上結衣")
                        .foregroundColor(Color.white)
                        .font(Font.system(size: 48))
                        .padding(.top, 156)
                    Spacer()
                    HStack {
                        VStack {
                            NavigationLink(destination: TutorialThirdView()) {
                                Image(R.image.profileCallEnd.name)
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .padding(16)
                                    .background(Color.red)
                                    .cornerRadius(32)
                            }
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                incomingAudioPlayer?.setVolume(0, fadeDuration: 1)
                                withAnimation {
                                    self.isCalling = false
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    guard let voice = NSDataAsset(name: "com_swiswiswift_inoue_yui_alarm_0") else {
                                        return
                                    }
                                    self.voiceAudioPlayer = try? AVAudioPlayer(data: voice.data)
                                    self.voiceAudioPlayer?.play()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    withAnimation {
                                        self.showingNextButton = true
                                    }
                                }
                            }) {
                                Image(R.image.profileCall.name)
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .padding(16)
                                    .background(Color.green)
                                    .cornerRadius(32)
                            }
                        }
                    }
                    .padding(.horizontal, 64)
                    .padding(.bottom, 32)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color("charalarm-default-gray"))
            }
            
            if showingNextButton {
                NavigationLink(
                    destination: TutorialThirdView()
                        .environmentObject(appState),
                    label: {
                        TutorialButtonContent(text: "つぎへ")
                            .padding(.horizontal, 16)
                    })
                    .padding(.bottom, 32)
            }
        }
        .onAppear {
            incoming()
        }
        .onDisappear {
            fadeOut()
        }
        .edgesIgnoringSafeArea(.all)
        .navigationTitle("")
        .navigationBarHidden(true)
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
        incomingAudioPlayer?.setVolume(0.0, fadeDuration: 0.5)
        voiceAudioPlayer?.setVolume(0.0, fadeDuration: 0.5)
    }
}

struct TutorialSecondView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TutorialSecondView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            TutorialSecondView()
                .environmentObject(CharalarmAppState(appVersion: "2.0.0"))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
