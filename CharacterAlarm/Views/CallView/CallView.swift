import SwiftUI
import SDWebImageSwiftUI

struct CallView: View {
    let characterId: String
    let characterName: String
    
    @State var overlay = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            VStack {
                WebImage(url: URL(string: "https://charalarm.com/image/\(self.characterId)/thumbnail_list.png"))
                    .resizable()
                    .placeholder {
                        Image("character-placeholder")
                            .resizable()
                }
                .animation(.easeInOut(duration: 0.5))
                .transition(.fade)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .scaledToFill()
                
                Text(characterName)
                
                Spacer()
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Button")
                }
            }
            
            if overlay {
                VStack {
                    
                    Text("ssss")
                    Spacer()

                    
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            Text("Dissmiss")
                        }
                        Spacer()
                        Button(action: {
                            print("xxx")
                            withAnimation {

                            self.overlay = false
                            }
                        }){
                            Text("Appear")
                        }
                    }
                }.background(Color.gray)
            }
            
        }
    }
}

struct CallView_Previews: PreviewProvider {
    static var previews: some View {
        CallView(characterId: "xxx", characterName: "yyy")
    }
}
