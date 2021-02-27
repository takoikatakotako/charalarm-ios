import SwiftUI
import AVFoundation
import CallKit
import PushKit
import AVKit

struct TopView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @StateObject var viewModel = TopViewModel()
    
    var body: some View {
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
                    .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.newsButtonTapped()
                        }) {
                            Image(R.image.topNews.name)
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
                            viewModel.characterListButtonTapped()
                        }) {
                            TopButtonContent(imageName: R.image.topPerson.name)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.alarmButtonTapped()
                        }) {
                            TopButtonContent(imageName: R.image.topAlarm.name)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.configButtonTapped()
                        }) {
                            TopButtonContent(imageName: R.image.topConfig.name)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 32)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.gray.opacity(0.2)]), startPoint: UnitPoint(x: 0.5, y: 0.03), endPoint: UnitPoint(x: 0.5, y: 0)).opacity(0.9))
            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.setChara)) { _ in
            viewModel.setChara()
        }
        .onAppear {
            viewModel.onAppear()
            viewModel.setChara()
        }
        .alert(item: $viewModel.alert) { item in
            switch item {
            case .failedToGetCharacterInformation:
                return Alert(title: Text(""), message: Text(R.string.localizable.errorFailedToGetCharacterInformation()), dismissButton: .default(Text(R.string.localizable.commonClose())))
            case .failedToGetCharacterSelectionInformation:
                return Alert(title: Text(""), message: Text(R.string.localizable.errorFailedToGetCharacterSelectionInformation()), dismissButton: .default(Text(R.string.localizable.commonClose())))
            case .failedToGetCharactersResources:
                return Alert(title: Text(""), message: Text(R.string.localizable.errorFailedToGetCharactersResources()), dismissButton: .default(Text(R.string.localizable.commonClose())))
            case .failedToSetCharacterImage:
                return Alert(title: Text(""), message: Text(R.string.localizable.errorFailedToSetCharacterImage()), dismissButton: .default(Text(R.string.localizable.commonClose())))
            case .thisFeatureIsNotAvailableInYourRegion:
                return Alert(title: Text(""), message: Text(R.string.localizable.errorThisFeatureIsNotAvailableInYourRegion()), dismissButton: .default(Text(R.string.localizable.commonClose())))
            }
        }
        .sheet(item: $viewModel.sheet) {
            // On Dissmiss
        } content: { item in
            switch item {
            case .newsList:
                NewsListView()
            case .characterList:
                CharacterListView()
                    .environmentObject( appState )
            case .alarmList:
                AlarmListView()
                    .environmentObject( appState )
            case .config:
                ConfigView()
                    .environmentObject( appState )
            }
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
