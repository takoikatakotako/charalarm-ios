import UIKit
import FirebaseAuth

class ConfigModel {

    func xxxxxx(completion: @escaping (String) -> Void) {
        Auth.auth().signInAnonymously { (authResult, _) in
            guard let user = authResult?.user else { return }
            let uid = user.uid
            completion(uid)
        }
    }

    func getVersion() -> String {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
            let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
                return ""
        }
        return "\(version)(\(build))"
    }
}
