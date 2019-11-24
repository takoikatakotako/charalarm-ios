import UIKit

class ConfigViewModel: ObservableObject {
    let model: ConfigModel = ConfigModel()

    let versionString: String

    init() {
        versionString = model.getVersion()
    }

    func openUrlString(string: String) {
        guard let url = URL(string: string) else {
            return
        }
        UIApplication.shared.open(url)
    }
}
