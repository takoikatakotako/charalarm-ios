import UIKit

class ConfigViewModel: ObservableObject {
    let model: ConfigModel = ConfigModel()
    var uid: String = ""
    let versionString: String

    init() {
        versionString = model.getVersion()
        model.xxxxxx { uid in
            self.uid = uid
        }
    }

    func openUrlString(string: String) {
        guard let url = URL(string: string) else {
            return
        }
        UIApplication.shared.open(url)
    }
}
