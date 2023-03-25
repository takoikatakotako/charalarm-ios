import SwiftUI
import StoreKit
import SDWebImageSwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewState: ProfileViewState
    
    var body: some View {
        GeometryReader { geometory in
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    WebImage(url: URL(string: viewState.charaThumbnailUrlString))
                        .resizable()
                        .placeholder {
                            Image(R.image.characterPlaceholder.name)
                                .resizable()
                        }
                        .animation(.easeInOut(duration: 0.5))
                        .transition(.fade)
                        .frame(width: geometory.size.width, height: geometory.size.width)
                        .scaledToFill()
                    
                    ProfileRow(title: R.string.localizable.profileName(), text: viewState.character?.name ?? "", urlString: "")
                    ProfileRow(title: R.string.localizable.profileProfile(), text: viewState.character?.description ?? "", urlString: "")
                    
                    if let profiles = viewState.character?.profiles {
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
                        if self.viewState.showCallItem {
                            Button(action: {
                                guard viewState.character?.charaDomain != nil || viewState.character?.name != nil else {
                                    return
                                }
                                viewState.showCallView = true
                            }) {
                                MenuItem(imageName: R.image.profileCall.name)
                            }.sheet(isPresented: $viewState.showCallView) {
                                CallView(charaDomain: viewState.character?.charaDomain ?? "", charaName: viewState.character?.name ?? "")
                            }
                            .sheet(
                                isPresented: $viewState.showCallView,
                                onDismiss: {
                                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                        SKStoreReviewController.requestReview(in: scene)
                                    }
                                }) {
                                    CallView(charaDomain: viewState.character?.charaDomain ?? "", charaName: viewState.character?.name ?? "")
                                }
                        }
                        if self.viewState.showCheckItem {
                            Button(action: {
                                viewState.showSelectAlert = true
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
                
                
                if viewState.showingDownloadingModal {
                    VStack {
                        if viewState.downloadError {
                            Text(R.string.localizable.profileFailedToDownloadResources())
                                .font(Font.system(size: 24))
                                .foregroundColor(Color.white)
                            Button {
                                viewState.close()
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
                            Text(viewState.progressMessage)
                                .font(Font.system(size: 24))
                                .foregroundColor(Color.white)
                            
                            Button {
                                viewState.cancel()
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
            viewState.fetchCharacter()
        }.alert(isPresented: self.$viewState.showSelectAlert) {
            Alert(
                title: Text(R.string.localizable.profileCharacterSelection()),
                message: Text(R.string.localizable.profileWantToCallThisCharacter()),
                primaryButton: .default(Text(R.string.localizable.commonClose())) {
                }, secondaryButton: .default(Text(R.string.localizable.profileYes())) {
                    viewState.selectCharacter()
                })
        }
    }
    
    func showMenu() {
        withAnimation {
            self.viewState.showCheckItem.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.viewState.showCallItem.toggle()
            }
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        var body: some View {
            ProfileView(viewState: ProfileViewState(charaID: "com.example.xxx"))
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
