import SwiftUI

struct TutorialFirstView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                
                Text("キャラームへようこそ！\nこのアプリはアラームをキャラクターが電話で通知するアプリです。")
                
                Text("さっそくアラームをためしてみてください")
                
                Image("sd-normal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Spacer()
                
                NavigationLink(
                    destination: TutorialSecondView(),
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
            .background(Color.white)
        }
    }
}

struct TutorialFirstView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialFirstView()
    }
}
