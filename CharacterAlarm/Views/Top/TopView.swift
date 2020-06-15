import SwiftUI
import AVFoundation

fileprivate struct Dispachers {
    let alarmDispacher = AlarmActionDispacher()
}

fileprivate let dispachers = Dispachers()

struct TopView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel = TopViewModel()
    
    var body: some View {
        GeometryReader { geometory in
            ZStack {
                Image("background")
                    .resizable()
                    .frame(width: geometory.size.width, height: geometory.size.height)
                    .scaledToFill()

                VStack(spacing: 0) {
                    Spacer()
                    Image("normal")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometory.size.width, height: geometory.size.height - 60)
                }

                Button(action: {
                    self.viewModel.tapped()
                }) {
                    Text("")
                        .frame(width: geometory.size.width, height: geometory.size.height)
                }

                VStack(spacing: 0) {
                    Spacer()
                    HStack(alignment: .bottom, spacing: 16) {
                        TopTimeView()
                        Spacer()
                        
                        Button(action: {
                            self.viewModel.showNews = true
                        }) {
                            TopButtonContent(imageName: "top-news")
                        }.sheet(isPresented: self.$viewModel.showNews) {
                            // NewsView()
                            CallView(characterId: "com.swiswiswift.charalarm.yui", characterName: "yui")
                        }

                        Button(action: {
                            
                            print(self.appState.alarmState.alarms.count)
                            
                            self.viewModel.showConfig = true
                        }) {
                            TopButtonContent(imageName: "top-config")
                        }.sheet(isPresented: self.$viewModel.showConfig) {
                            ConfigView().environmentObject( self.appState )
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 28)
            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .onAppear {
            dispachers.alarmDispacher.fetchAlarmList()
        }
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
