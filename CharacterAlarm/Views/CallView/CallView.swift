import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct CallView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: CallViewModel
    
    init(charaDomain: String, charaName: String) {
        self.viewModel = CallViewModel(charaDomain: charaDomain, charaName: charaName)
    }
    
    var body: some View {
        ZStack {
            VStack {
                WebImage(url: URL(string: viewModel.charaThumbnailUrlString))
                    .resizable()
                    .placeholder {
                        Image("character-placeholder")
                            .resizable()
                }
                .animation(.easeInOut(duration: 0.5))
                .transition(.fade)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .scaledToFill()
                
                Text(viewModel.charaName)
                
                Spacer()
                
                Button(action: {
                    self.viewModel.fadeOut()
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "phone.fill.arrow.down.left")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 40, height: 40)                }
                    .frame(width: 80, height: 80)
                    .background(Color("call-red"))
                    .cornerRadius(40)
            }                    .padding(.bottom, 60)
            
            
            if viewModel.overlay {
                VStack {
                    Text(viewModel.charaName)
                        .font(Font.system(size: 36))
                        .foregroundColor(Color.white)
                        .padding(.top, 80)
                    Spacer()
                    
                    HStack(spacing: 160) {
                        Button(action: {
                            self.viewModel.fadeOut()
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            
                            Image(systemName: "phone.fill.arrow.down.left")
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 40, height: 40)
                        }
                        .frame(width: 80, height: 80)
                        .background(Color("call-red"))
                        .cornerRadius(40)
                        
                        
                        Button(action: {
                            self.viewModel.call()
                            withAnimation {
                                self.viewModel.overlay = false
                            }
                        }){
                            Image(systemName: "phone.fill")
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 40, height: 40)
                        }
                        .frame(width: 80, height: 80)
                        .background(Color("call-green"))
                        .cornerRadius(40)
                        
                    }
                    .padding(.bottom, 60)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray)
            }
        }.edgesIgnoringSafeArea(.bottom)
            .onAppear {
                self.viewModel.incoming()
        }
    }
}

struct CallView_Previews: PreviewProvider {
    static var previews: some View {
        CallView(charaDomain: "com.charalarm.yui", charaName: "井上結衣")
    }
}
