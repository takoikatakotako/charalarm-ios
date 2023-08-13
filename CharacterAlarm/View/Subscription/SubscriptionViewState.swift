import StoreKit

class SubscriptionViewState: ObservableObject {
    @Published var product: Product?
    @Published var showingAlert: Bool = false
    @Published var alertMessage: String?
    
    var priceMessage: String {
        if let product = product, let period = product.subscription?.subscriptionPeriod {
            return "\(product.displayPrice) / \(period.unit)"
        } else {
            return "-- / --"
        }
    }
    
    @MainActor
    func onAppear() {
        Task {
            do {
                guard let product = try await fetchProducts() else {
                    alertMessage = "不明なエラーです"
                    showingAlert = true
                    return
                }
                self.product = product
            } catch {
                alertMessage = "不明なエラーです"
                showingAlert = true
               //  view.showErrorAlert(title: "", message: R.string.localizable.subscriptionFailToGetProductInfo())
            }
        }
    }
    
    
    @MainActor
    func upgradeButtonTapped() {
        guard let product = self.product else {
            // view.showErrorAlert(title: "", message: R.string.localizable.subscriptionFailToGetProductInfo())
            return
        }
        
        Task {
            // view.showFullScreenIndicator()
            do {
                let transaction = try await purchase(product: product)
                // model.enablePrivilege()
                await transaction.finish()
                // view.hideFullScreenIndicator()
                // view.showErrorAlert(title: "", message: R.string.localizable.subscriptionCompletToPurchase())
            } catch {
                // view.hideFullScreenIndicator()
                // view.showErrorAlert(title: "", message: R.string.localizable.subscriptionInteruptPurchase())
            }
        }
    }
    
    private func fetchProducts() async throws -> Product? {
        let productIdList = ["charalarm.development.monthly.subscription"]
        let products: [Product] = try await Product.products(for: productIdList)
        guard let product = products.first else {
            return nil
        }
        return product
    }
    
    private func purchase(product: Product) async throws -> Transaction  {
        // Product.PurchaseResultの取得
        let purchaseResult: Product.PurchaseResult
        do {
            purchaseResult = try await product.purchase()
        } catch Product.PurchaseError.productUnavailable {
            throw SubscribeError.productUnavailable
        } catch Product.PurchaseError.purchaseNotAllowed {
            throw SubscribeError.purchaseNotAllowed
        } catch {
            throw SubscribeError.otherError
        }

        // VerificationResultの取得
        let verificationResult: VerificationResult<Transaction>
        switch purchaseResult {
        case .success(let result):
            verificationResult = result
        case .userCancelled:
            throw SubscribeError.userCancelled
        case .pending:
            throw SubscribeError.pending
        @unknown default:
            throw SubscribeError.otherError
        }

        // Transactionの取得
        switch verificationResult {
        case .verified(let transaction):
            return transaction
        case .unverified:
            throw SubscribeError.failedVerification
        }
    }
}
