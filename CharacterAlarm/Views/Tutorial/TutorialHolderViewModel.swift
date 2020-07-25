import Foundation

fileprivate struct Dispachers {
    let settingDispacher = SettingActionDispacher()
}

fileprivate let dispachers = Dispachers()

class TutorialHolderViewModel: ObservableObject {
    let anonymousUserName = UUID().uuidString
    let anonymousUserPassword = UUID().uuidString
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func signUp() {
        
        let url = URL(string: BASE_URL + "/api/anonymous/auth/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
        request.allHTTPHeaderFields = header
        
        let anonymousAuthBean = AnonymousAuthBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword)
        guard let httpBody = try? JSONEncoder().encode(anonymousAuthBean) else {
            print("AnonymousAuthBeanのパースに失敗しました。")
            self.showingAlert = true
            self.alertMessage = "不明なエラーが発生しました。"
            return
        }
        request.httpBody = httpBody


        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("クライアントサイドエラー: \(error.localizedDescription)")
                self.showingAlert = true
                self.alertMessage = "不明なエラーが発生しました。"
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("通信に失敗しました。")
                self.showingAlert = true
                self.alertMessage = "通信に失敗しました。"
                return
            }
            
            if response.statusCode == 200 {
                // ユーザー作成に成功
                UserDefaults.standard.set(self.anonymousUserName, forKey: ANONYMOUS_USER_NAME)
                UserDefaults.standard.set(self.anonymousUserPassword, forKey: ANONYMOUS_USER_PASSWORD)
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)")
                print("サーバサイドエラー ステータスコード: \(response)")
                print(data)
                self.showingAlert = true
                self.alertMessage = "ユーザの作成に失敗しました。"
            }
        }
        task.resume()
    }
    
}
