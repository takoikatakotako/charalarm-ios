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
                    Text(R.string.localizable.subscriptionMessage())
                    
                    SubscriptionCardView(
                        title: R.string.localizable.subscriptionBenefit1Title(),
                        systemImageName: "calendar",
                        description: R.string.localizable.subscriptionBenefit1Description()
                    )
                    
                    SubscriptionCardView(
                        title: R.string.localizable.subscriptionBenefit2Title(),
                        systemImageName: "nosign",
                        description: R.string.localizable.subscriptionBenefit2Description()
                    )
                    
                    Button {
                        viewState.upgradeButtonTapped()
                    } label: {
                        VStack(spacing: 8) {
                            Text(R.string.localizable.subscriptionUpdatePremiumPlan())
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
                    
                    Button {
                        viewState.restore()
                    } label: {
                        Text(R.string.localizable.subscriptionRestore())
                    }
                    
                    HStack {
                        Button {
                            viewState.openTeams()
                        } label: {
                            Text(R.string.localizable.commonTerms())
                        }
                        Button {
                            viewState.openPrivacyPolicy()
                        } label: {
                            Text(R.string.localizable.commonPrivacy())
                        }
                    }
//                    
//                    Button {
//                        viewState.openAboutCancel()
//                    } label: {
//                        Text(R.string.localizable.subscriptionAboutCancellationMethod())
//                    }
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
            Button(R.string.localizable.commonClose()) {
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
