import UIKit

class ConfigViewModel {

    func openUrlString(string: String) {
        guard let url = URL(string: string) else {
            return
        }
        UIApplication.shared.open(url)
    }
}
