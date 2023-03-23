import SwiftUI
import StoreKit
import SDWebImageSwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: ProfileViewModel
    
    init(charaDomain: String) {
        viewModel = ProfileViewModel(charaDomain: charaDomain)
    }
    
    var body: some View {
        GeometryReader { geometory in
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    WebImage(url: URL(string: viewModel.charaThumbnailUrlString))
                        .resizable()
                        .placeholder {
                            Image(R.image.characterPlaceholder.name)
                                .resizable()
                        }
                        .animation(.easeInOut(duration: 0.5))
                        .transition(.fade)
                        .frame(width: geometory.size.width, height: geometory.size.width)
                        .scaledToFill()
                    
                    ProfileRow(title: R.string.localizable.profileName(), text: viewModel.character?.name ?? "", urlString: "")
                    ProfileRow(title: R.string.localizable.profileProfile(), text: viewModel.character?.description ?? "", urlString: "")
                    
                    if let profiles = viewModel.character?.profiles {
                        ForEach(profiles, id: \.hashValue) { profile in
                            ProfileRow(title: profile.title, text: profile.name, urlString: profile.url)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 120)
                }
                
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack {
                        Spacer()
                        if self.viewModel.showCallItem {
                            Button(action: {
                                guard viewModel.character?.charaDomain != nil || viewModel.character?.name != nil else {
                                    return
                                }
                                viewModel.showCallView = true
                            }) {
                                MenuItem(imageName: R.image.profileCall.name)
                            }.sheet(isPresented: $viewModel.showCallView) {
                                CallView(charaDomain: viewModel.character?.charaDomain ?? "", charaName: viewModel.character?.name ?? "")
                            }
                            .sheet(
                                isPresented: $viewModel.showCallView,
                                onDismiss: {
                                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                        SKStoreReviewController.requestReview(in: scene)
                                    }
                                }) {
                                    CallView(charaDomain: viewModel.character?.charaDomain ?? "", charaName: viewModel.character?.name ?? "")
                                }
                        }
                        if self.viewModel.showCheckItem {
                            Button(action: {
                                viewModel.showSelectAlert = true
                            }) {
                                MenuItem(imageName: R.image.profileCheck.name)
                            }
                        }
                        Button(action: {
                            showMenu()
                        }) {
                            Group {
                                Image(R.image.profileMenuIcon.name)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            }.accentColor(.white)
                                .frame(width: 80, height: 80)
                                .background(Color.black)
                                .cornerRadius(40)
                                .shadow(color: .black, radius: 4, x: 4, y: 4)
                                .opacity(0.9)
                        }
                    }
                    .padding()
                }
                
                
                if viewModel.showingDownloadingModal {
                    VStack {
                        if viewModel.downloadError {
                            Text(R.string.localizable.profileFailedToDownloadResources())
                                .font(Font.system(size: 24))
                                .foregroundColor(Color.white)
                            Button {
                                viewModel.close()
                            } label: {
                                Text(R.string.localizable.commonClose())
                                    .font(Font.system(size: 24))
                                    .foregroundColor(Color.white)
                                    .padding(.top, 16)
                            }
                        } else {
                            Text(R.string.localizable.profileDownloadingResources())
                                .font(Font.system(size: 24))
                                .foregroundColor(Color.white)
                            Text(viewModel.progressMessage)
                                .font(Font.system(size: 24))
                                .foregroundColor(Color.white)
                            
                            Button {
                                viewModel.cancel()
                            } label: {
                                Text(R.string.localizable.commonCancel())
                                    .font(Font.system(size: 24))
                                    .foregroundColor(Color.white)
                                    .padding(.top, 16)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color.black.opacity(0.6))
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                BackBarButton() {
                    presentationMode.wrappedValue.dismiss()
                }
        )
        .onAppear {
            viewModel.fetchCharacter()
        }.alert(isPresented: self.$viewModel.showSelectAlert) {
            Alert(
                title: Text(R.string.localizable.profileCharacterSelection()),
                message: Text(R.string.localizable.profileWantToCallThisCharacter()),
                primaryButton: .default(Text(R.string.localizable.commonClose())) {
                }, secondaryButton: .default(Text(R.string.localizable.profileYes())) {
                    viewModel.selectCharacter()
                })
        }
    }
    
    func showMenu() {
        withAnimation {
            self.viewModel.showCheckItem.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.viewModel.showCallItem.toggle()
            }
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        var body: some View {
            ProfileView(charaDomain: "com.example.xxx")
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
