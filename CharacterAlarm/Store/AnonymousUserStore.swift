import UIKit

class AnonymousUserStore {
    static func signup(anonymousUserName: String, anonymousUserPassword: String, completion: @escaping (Error?) -> Void) {
        
        let url = URL(string: BASE_URL + "/api/anonymous/auth/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
        request.allHTTPHeaderFields = header
        
        let anonymousAuthBean = AnonymousAuthBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword)
        guard let httpBody = try? JSONEncoder().encode(anonymousAuthBean) else {
            print("AnonymousAuthBeanのパースに失敗しました。")
            completion(CharalarmError.parseError)
            return
        }
        request.httpBody = httpBody


        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(CharalarmError.clientError)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(CharalarmError.serverError)
                return
            }
            
            if response.statusCode == 200 {
                // ユーザー作成に成功
                guard let jsonResponse = try? JSONDecoder().decode(JsonResponseBean<String>.self, from: data) else {
                    completion(CharalarmError.parseError)
                    return
                }
                print(jsonResponse)
                completion(nil)
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)")
                print("サーバサイドエラー ステータスコード: \(response)")
                print(data)
                completion(CharalarmError.serverError)
            }
        }
        task.resume()
    }
}
