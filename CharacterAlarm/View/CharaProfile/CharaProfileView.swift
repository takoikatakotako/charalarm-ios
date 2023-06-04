import SwiftUI
import StoreKit
import SDWebImageSwiftUI

struct CharaProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewState: CharaProfileViewState
    
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
                    
                    CharaProfileRow(title: R.string.localizable.profileName(), text: viewState.chara?.name ?? "", urlString: "")
                    CharaProfileRow(title: R.string.localizable.profileProfile(), text: viewState.chara?.description ?? "", urlString: "")
                    
                    if let profiles = viewState.chara?.profiles {
                        ForEach(profiles, id: \.hashValue) { profile in
                            CharaProfileRow(title: profile.title, text: profile.name, urlString: profile.url)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 60)
                }
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Spacer()
                        Button(action: {
                            guard viewState.chara?.charaID != nil || viewState.chara?.name != nil else {
                                return
                            }
                            viewState.showCallView = true
                        }) {
                            MenuItem(imageName: R.image.profileCall.name)
                        }
                        
                        Button(action: {
                            viewState.showSelectAlert = true
                        }) {
                            MenuItem(imageName: R.image.profileCheck.name)
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
        }
        .alert(isPresented: self.$viewState.showSelectAlert) {
            Alert(
                title: Text(R.string.localizable.profileCharacterSelection()),
                message: Text(R.string.localizable.profileWantToCallThisCharacter()),
                primaryButton: .default(Text(R.string.localizable.commonClose())) {
                }, secondaryButton: .default(Text(R.string.localizable.profileYes())) {
                    viewState.selectCharacter()
                })
        }
        .sheet(isPresented: $viewState.showCallView) {
            CallView(viewState: CallViewState(charaDomain: viewState.chara?.charaID ?? "", charaName: viewState.chara?.name ?? ""))
        }
        .sheet(
            isPresented: $viewState.showCallView,
            onDismiss: {
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }) {
                CallView(viewState: CallViewState(charaDomain: viewState.chara?.charaID ?? "", charaName: viewState.chara?.name ?? ""))
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        var body: some View {
            CharaProfileView(viewState: CharaProfileViewState(charaID: "com.example.xxx"))
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
