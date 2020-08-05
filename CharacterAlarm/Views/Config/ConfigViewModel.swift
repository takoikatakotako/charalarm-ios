import UIKit

class ConfigViewModel: ObservableObject {
    @Published var character: Character?
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    var versionString: String {
        return getVersion()
    }
    
    func openUrlString(string: String) {
        guard let url = URL(string: string) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func fetchCharacter(characterId: String) {
        CharacterStore.fetchCharacter(charaDomain: characterId) { error, character in
            if let error = error {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = error.localizedDescription
                }
                return
            }
            
            guard let character = character else {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = "所得に失敗しました"
                }
                return
            }
            
            DispatchQueue.main.async {
                self.character = character
            }
        }
    }
    
    func withdraw() {
        guard let anonymousUserName = UserDefaults.standard.string(forKey: ANONYMOUS_USER_NAME),
            let anonymousUserPassword = UserDefaults.standard.string(forKey: ANONYMOUS_USER_PASSWORD) else {
                self.showingAlert = true
                self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                return
        }
        
        UserDefaults.standard.set(nil, forKey: ANONYMOUS_USER_NAME)
        UserDefaults.standard.set(nil, forKey: ANONYMOUS_USER_PASSWORD)
    }
    
    private func getVersion() -> String {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
            let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
                return ""
        }
        return "\(version)(\(build))"
    }
}
