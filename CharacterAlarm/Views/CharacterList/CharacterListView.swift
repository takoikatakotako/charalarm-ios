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
                        guard let url = URL(string: "https://swiswiswift.com/") else {
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
            }
            .onAppear {
                self.viewModel.fetchCharacters()
            }
            .alert(isPresented: self.$viewModel.showingAlert) {
                Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
            }
            .navigationBarTitle("キャラクター一覧", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image("common-icon-close")
                                            .renderingMode(.template)
                                            .foregroundColor(Color("charalarm-default-gray"))
                                    }
            )
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
