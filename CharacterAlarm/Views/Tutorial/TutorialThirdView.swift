import SwiftUI

struct TutorialThirdView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Image("sd-normal")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            
            Text("無事に着信できたでしょうか？アラームは時間や曜日を指定して複数セットすることができます")
            Spacer()
            
            NavigationLink(
                destination: TutorialFourthView(),
                label: {
                    Text("アラームを鳴らしてみる")
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

struct TutorialThirdView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialThirdView()
    }
}
