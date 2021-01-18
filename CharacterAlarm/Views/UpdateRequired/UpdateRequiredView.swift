import SwiftUI

struct UpdateRequiredView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("アップデートが必要です")
                .font(Font.system(size: 28))
                .padding()
            VStack(alignment: .leading) {
                Text("アプリのアップデートが必要です。")
                Text("ストアから最新版のアプリのインストールをお願いします。")
            }
            .padding()
            
            Button(action: {
                if let url = URL(string: CharalarmAppStoreUrlString) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("App Storeを開く")
                    .font(Font.system(size: 20))
            }
            .padding()
        }
    }
}

struct UpdateRequiredView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRequiredView()
    }
}
