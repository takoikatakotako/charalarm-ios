import SwiftUI
import AVFoundation
import CallKit
import PushKit

struct TopView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @ObservedObject var viewModel = TopViewModel()
    
    var body: some View {
        GeometryReader { geometory in
            ZStack {
                Image("background")
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
                    self.viewModel.tapped()
                }) {
                    Text("")
                        .frame(width: geometory.size.width, height: geometory.size.height)
                }
                
                VStack(spacing: 0) {
                    
                    // 
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            Button(action: {
                                self.viewModel.showNews = true
                            }) {
                                TopButtonContent(imageName: "top-news")
                            }.sheet(isPresented: self.$viewModel.showNews) {
                                NewsListView()
                            }
                            .padding()
                            .padding(.top, 16)
                        }
                        .frame(height: 140)
                        .background(LinearGradient(gradient: Gradient(colors: [.gray, .clear]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1)))
                    }

                    Spacer()
                    HStack {
                        Spacer()
                        TopTimeView()
                        Spacer()
                    }
                    .frame(height: 140)
                    .background(LinearGradient(gradient: Gradient(colors: [.gray, .clear]), startPoint: UnitPoint(x: 0.5, y: 1), endPoint: UnitPoint(x: 0.5, y: 0)))
                    
                    
                    HStack {
                        Button(action: {
                            self.viewModel.showCharaList = true
                        }) {
                            TopButtonContent(imageName: "top-person")
                        }.sheet(isPresented: self.$viewModel.showCharaList) {
                            CharacterListView()
                                .environmentObject( self.appState )
                        }
                        
                        Button(action: {
                            self.viewModel.showAlarmList = true
                        }) {
                            TopButtonContent(imageName: "top-alarm")
                        }.sheet(isPresented: self.$viewModel.showAlarmList) {
                            AlarmListView()
                                .environmentObject( self.appState )
                        }
                        
                        Button(action: {
                            self.viewModel.showConfig = true
                        }) {
                            TopButtonContent(imageName: "top-config")
                        }.sheet(isPresented: self.$viewModel.showConfig) {
                            ConfigView()
                                .environmentObject( self.appState )
                        }
                    }
                    
                }

            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.setChara)) { _ in
            self.viewModel.setChara()
        }
        .onAppear {
            self.viewModel.setChara()
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
