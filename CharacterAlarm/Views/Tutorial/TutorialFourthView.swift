import SwiftUI

struct TutorialFourthView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Image("sd-normal")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Spacer()
            
            
            Text("キャラクター一覧から着信を受けられるキャラクターを見ることができます。好きなキャラクターを選んでみてください。")
            
            NavigationLink(
                destination: TutorialFifthView(),
                label: {
                    Text("つぎへ")
                        .foregroundColor(Color.white)
                        .font(Font.system(size: 16).bold())
                        .frame(height: 46)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("charalarm-default-green"))
                        .cornerRadius(24)
                        .padding(.horizontal, 16)
                })
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct TutorialFourthView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialFourthView()
    }
}
