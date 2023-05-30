import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct CharaListView: View {
    @StateObject var viewState: CharacterListViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewState.charaList) { chara in
                    NavigationLink(destination: CharaProfileView(viewState: CharaProfileViewState(chara: chara))) {
                        CharacterListRow(character: chara)
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
            .alert(isPresented: $viewState.showingAlert) {
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
            CharaListView(viewState: CharacterListViewModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            CharaListView(viewState: CharacterListViewModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
