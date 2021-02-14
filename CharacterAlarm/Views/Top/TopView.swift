import SwiftUI
import AVFoundation
import CallKit
import PushKit
import AVKit

struct TopView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @StateObject var viewModel = TopViewModel()
    
    var body: some View {
        GeometryReader { geometory in
            ZStack {
                Image(R.image.background.name)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                
                VStack(spacing: 0) {
                    Image(uiImage: viewModel.charaImage)
                        .resizable()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .scaledToFit()
                        .padding(.top, 60)
                }
                
                Button(action: {
                    viewModel.tapped()
                }) {
                    Text("")
                        .frame(width: geometory.size.width, height: geometory.size.height)
                }
                
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.showNews = true
                            }) {
                                Image(R.image.topNews.name)
                            }.sheet(isPresented: $viewModel.showNews) {
                                NewsListView()
                            }
                            .padding()
                            .padding(.top, 8)
                        }
                        .frame(height: 140)
                        .background(LinearGradient(gradient: Gradient(colors: [.gray, .clear]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1)))
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 8) {
                        TopTimeView()
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.showCharaList = true
                            }) {
                                TopButtonContent(imageName: R.image.topPerson.name)
                            }.sheet(isPresented: $viewModel.showCharaList) {
                                CharacterListView()
                                    .environmentObject( appState )
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                guard Locale.current.regionCode != "CN" else {
                                    viewModel.showingAlert = true
                                    viewModel.alertMessage = "对不起。此功能在您所在的地区不可用。"
                                    return
                                }
                                viewModel.showAlarmList = true
                            }) {
                                TopButtonContent(imageName: R.image.topAlarm.name)
                            }.sheet(isPresented: self.$viewModel.showAlarmList) {
                                AlarmListView()
                                    .environmentObject( appState )
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.showConfig = true
                            }) {
                                TopButtonContent(imageName: R.image.topConfig.name)
                            }.sheet(isPresented: $viewModel.showConfig) {
                                ConfigView()
                                    .environmentObject( appState )
                            }
                            
                            Spacer()
                        }
                        .padding(.bottom, 32)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.gray.opacity(0.2)]), startPoint: UnitPoint(x: 0.5, y: 0.03), endPoint: UnitPoint(x: 0.5, y: 0)).opacity(0.9))
                }
            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.setChara)) { _ in
            viewModel.setChara()
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                guard granted else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
            viewModel.setChara()
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TopView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone 11")
                .environment(\.colorScheme, .light)
            TopView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}
