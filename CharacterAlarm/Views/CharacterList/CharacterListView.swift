import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct CharacterListView: View {
    @ObservedObject(initialValue: CharacterListViewModel()) var viewModel: CharacterListViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.characters) { character in
                    NavigationLink(destination: ProfileView(charaDomain: character.charaDomain)) {
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
                self.viewModel.fetchCharacters()
            }
            .alert(isPresented: self.$viewModel.showingAlert) {
                Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text(R.string.localizable.commonClose())))
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
            CharacterListView()
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            CharacterListView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
