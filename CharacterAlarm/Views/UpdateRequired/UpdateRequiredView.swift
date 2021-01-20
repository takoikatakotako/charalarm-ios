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
            
            Image(R.image.sdNormal.name)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            
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
        Group {
            UpdateRequiredView()
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            UpdateRequiredView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
