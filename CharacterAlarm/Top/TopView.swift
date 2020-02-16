import SwiftUI
import AVFoundation

struct TopView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject(initialValue: TopViewModel()) var viewModel: TopViewModel
    var body: some View {

        GeometryReader { geometory in
            ZStack {
                Image("background")
                    .resizable()
                    .frame(width: geometory.size.width, height: geometory.size.height)
                    .scaledToFill()

                VStack {
                    Spacer()
                    Image("normal")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometory.size.width, height: geometory.size.height - 60)
                }

                Button(action: {
                    print("Action\(self.appState.isCalling)")
                    if let sound = NSDataAsset(name: "com_swiswiswift_inoue_yui_alarm_0") {
                        self.viewModel.audioPlayer = try? AVAudioPlayer(data: sound.data)
                        self.viewModel.audioPlayer?.play() // → これで音が鳴る
                    }
                }) {
                    Text("")
                        .frame(width: geometory.size.width, height: geometory.size.height)
                }

                VStack {
                    Spacer()
                    HStack {
                        TopTimeView()
                        Spacer()
                    }
                }
                .padding(24)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            self.viewModel.showNews = true
                        }) {
                            TopButtonContent(imageName: "top-news")
                        }.sheet(isPresented: self.$viewModel.showNews) {
                            NewsView()
                        }

                        Button(action: {
                            self.viewModel.showConfig = true
                        }) {
                            TopButtonContent(imageName: "top-config")
                        }.sheet(isPresented: self.$viewModel.showConfig) {
                            ConfigView().environmentObject( self.appState )
                        }
                    }.padding(24)
                }
            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone 11")
                .environment(\.colorScheme, .light)
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}
