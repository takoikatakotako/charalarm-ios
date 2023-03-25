import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct CharacterListView: View {
    @StateObject var viewState: CharacterListViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewState.characters) { character in
                    NavigationLink(destination: ProfileView(viewState: ProfileViewState(charaID: character.charaID))) {
                        CharacterListRow(character: character)
                            .frame(height: 80)
                            .clipped()
                    }
                }
                
                VStack {
                    Spacer()
                    Button(action: {
                        guard let url = URL(string: ContactAbountAddCharacterUrlString) else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        CharacterListBanner()
                            .padding(.horizontal, 16)
                    }
                }
                .padding(.bottom, 28)
            }
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                viewState.fetchCharacters()
            }
            .alert(isPresented: self.$viewState.showingAlert) {
                Alert(title: Text(""), message: Text(viewState.alertMessage), dismissButton: .default(Text(R.string.localizable.commonClose())))
            }
            .navigationBarTitle(R.string.localizable.characterCharacterList(), displayMode: .inline)
            .navigationBarItems(
                leading:
                    CloseBarButton() {
                        presentationMode.wrappedValue.dismiss()
                    }
            )
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharacterListView(viewState: CharacterListViewModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            CharacterListView(viewState: CharacterListViewModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
