import Foundation

fileprivate struct Dispachers {
    let settingDispacher = SettingActionDispacher()
}

fileprivate let dispachers = Dispachers()

class TutorialHolderViewModel: ObservableObject {
    var doneSignUp: Bool = false
    //
    func signUp() {
        
        let url = URL(string: BASE_URL + "/api/anonymous/auth/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
        request.allHTTPHeaderFields = header
        
        guard let anonymousUserName = UserDefaults.standard.string(forKey: ANONYMOUS_USER_ID),
            let anonymousUserPassword = UserDefaults.standard.string(forKey: ANONYMOUS_USER_PASSWORD) else {
                fatalError("しゅとくできませえええええん")
        }
        
        let anonymousAuthBean = AnonymousAuthBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword)
        guard let httpBody = try? JSONEncoder().encode(anonymousAuthBean) else {
            fatalError("しゅとくできませえええええん")
        }
        request.httpBody = httpBody
        
        print("****")
        print(request.curlString)
        print("****")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
            if let error = error {
                print("クライアントサイドエラー: \(error.localizedDescription) \n")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                return
            }
            
            if response.statusCode == 200 {
                print(data)
                // dispachers.settingDispacher.doneSignUp(true)            
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
                print("サーバサイドエラー ステータスコード: \(response)\n")
                print(#file)
                print(#function)
                print(#line)
            }
        }
        task.resume()
    }
    
}
