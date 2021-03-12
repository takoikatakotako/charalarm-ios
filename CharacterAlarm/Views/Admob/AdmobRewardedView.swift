import SwiftUI
import GoogleMobileAds
import UIKit

class AdmobRewardedHandler: NSObject{
    var rewardedAd: GADRewardedAd?
    func load() {
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-3940256099942544/1712485313", request: nil) { ad, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self

            print("Roloaded")
        }
    }

    func showAd(viewController: UIViewController) {
//        guard let rewardedAd = rewardedAd else {
//            return
//        }
//
//        let root = UIApplication.shared.windows.first?.rootViewController
//        rewardedAd.present(fromRootViewController: viewController) {
//
//        }
    }
}

extension AdmobRewardedHandler: GADFullScreenContentDelegate {
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print(error.localizedDescription)
    }

    // Called when an ad is dismissed
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {

    }

    // Called when an ad is dismissed
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {

    }
}
