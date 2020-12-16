import SwiftUI

struct TutorialSecondView: View {
    
    @State private var isCalling = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isCalling {
                VStack {
                    Spacer()
                    HStack {
                        VStack {
                            NavigationLink(destination: Text("xxx")) {
                                Image("profile-call")
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .padding(16)
                                    .background(Color.red)
                                    .cornerRadius(32)
                            }
                        }
                        
                        VStack {
                            Button(action: {
                                withAnimation {
                                    self.isCalling = false
                                }
                            }) {
                                Image("profile-call")
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .padding(16)
                                    .background(Color.green)
                                    .cornerRadius(32)
                            }
                        }
                    }
                    .padding(.bottom, 32)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color.gray)
            }
            
            if isCalling == false {
                VStack {
                    Spacer()
                    Image("normal")
                        .resizable()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .scaledToFit()
                        .padding(.top, 60)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}


struct TutorialSecondView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialSecondView()
    }
}
