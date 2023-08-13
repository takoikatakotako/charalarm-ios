import SwiftUI
import StoreKit

struct SubscriptionView: View {
    @StateObject var viewState: SubscriptionViewState
    var body: some View {
        ScrollView {
            VStack {
                Text("ここにすごいアイキャッチ画像")
                
                VStack {
                    Text("特典１: 設定アラーム数アップ")
                    // Image("")
                    Text("フリープランでは設定できるアラームは1つだけですが、アラームを10個まで設定することができます")
                }
                
                VStack {
                    Text("特典2: 広告表示なし")
                    // Image("")
                    Text("アプリ内の広告が全て非表示になります")
                }
                
                VStack {
                    Text("いつでもキャンセルOK")
                    Text("はじめの２週間無料")
                    Text(viewState.priceMessage)
                    
                    Button {
                        
                    } label: {
                        Text("課金してクレメンス")
                    }
                }
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("利用規約")
                    }
                    Button {
                        
                    } label: {
                        Text("プライバシーポリシー")
                    }
                }
                
                Button {
                    
                } label: {
                    Text("解約方法について")
                }
            }
        }
        .onAppear {
            viewState.onAppear()
        }
        .alert(
            viewState.alertMessage ?? "",
            isPresented: $viewState.showingAlert,
            presenting: viewState.alertMessage
        ) { entity in
            Button(entity) {
                print(entity)
            }
        } message: { entity in
            Text(entity)
        }
    }
}

struct PremiunPlanDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SubscriptionView(viewState: SubscriptionViewState())
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("プレミアムプラン")
        }
    }
}
