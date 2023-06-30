import SwiftUI
import GoogleMobileAds
import UIKit

class AdmobRewardedHandler: NSObject, ObservableObject {
    var rewardedAd: GADRewardedAd?
    func load() {
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-3940256099942544/1712485313", request: nil) { ad, error in
            if let error = error {
                Logger.sendError(error: error)
                return
            }
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
    }
    
    func showAd() {
        guard let rewardedAd = rewardedAd else {
            return
        }
        
        if let root = UIApplication.shared.windows.first?.rootViewController {
            rewardedAd.present(fromRootViewController: root) {
                
            }
        }
    }
}

extension AdmobRewardedHandler: GADFullScreenContentDelegate {
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        Logger.sendError(error: error)
    }
    
    // Called when an ad is dismissed
//    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//
//    }
    
    // Called when an ad is dismissed
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        
    }
}
