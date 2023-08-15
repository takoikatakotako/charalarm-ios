import SwiftUI
import StoreKit

struct SubscriptionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewState: SubscriptionViewState
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 20)

                    Spacer()
                }
                
                VStack(spacing: 20) {
                    Text("Charalarmのサブスクリプションプランに\nアップデートすることでいくつかの機能が解放されます！！")
                    
                    SubscriptionCardView(
                        title: "特典１: アラーム数上限アップ",
                        systemImageName: "calendar",
                        description: "アラームを10個まで設定することができます"
                    )
                    
                    SubscriptionCardView(
                        title: "特典2: 広告表示なし",
                        systemImageName: "nosign",
                        description: "アプリ内の広告が全て非表示になります"
                    )
                    
                    Button {
                        viewState.upgradeButtonTapped()
                    } label: {
                        VStack(spacing: 8) {
                            Text("プレミアムプランにアップデート")
                                .font(Font.system(size: 20).bold())
                            Text(viewState.priceMessage)
                                .font(Font.system(size: 16).bold())
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 1)
                                .shadow(color: Color.black, radius: 16, x: 0, y: 0)
                        )
                    }
                    .buttonStyle(.plain)
                    
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
                .padding()
            }
            
            if viewState.enableDisplayLock {
                VStack {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding()
                        .tint(Color.white)
                        .scaleEffect(3.0)
                }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(minHeight: 0, maxHeight: .infinity)
                    .background(Color.black.opacity(0.6))
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
        SubscriptionView(viewState: SubscriptionViewState())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("プレミアムプラン")
    }
}
