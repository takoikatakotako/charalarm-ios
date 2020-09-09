import Foundation

class PushStore {
    static func addPushToken(anonymousUserName: String, anonymousUserPassword: String, pushToken: String, completion: @escaping (Error?) -> Void) {
        let url = URL(string: BASE_URL + "/api/anonymous/token/ios/push/add")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
        request.allHTTPHeaderFields = header
        
        let anonymousPushTokenBean = AnonymousPushTokenBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword, pushToken: pushToken)
        guard let httpBody = try? JSONEncoder().encode(anonymousPushTokenBean) else {
            completion(CharalarmError.clientError)
            return
        }
        request.httpBody = httpBody
        
        
        print("****")
        print(request.curlString)
        print("****")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("クライアントサイドエラー: \(error.localizedDescription)")
                completion(CharalarmError.clientError)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(CharalarmError.serverError)
                return
            }
            print(data)
            
            if response.statusCode == 200 {
                completion(nil)
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
                print(#file)
                print(#function)
                print(#line)
                completion(CharalarmError.serverError)
            }
        }
        task.resume()
    }
    
    static func addVoipPushToken(anonymousUserName: String, anonymousUserPassword: String, pushToken: String, completion: @escaping (Error?) -> Void) {
        let url = URL(string: BASE_URL + "/api/anonymous/token/ios/voip-push/add")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
        request.allHTTPHeaderFields = header
        
        let anonymousPushTokenBean = AnonymousPushTokenBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword, pushToken: pushToken)
        guard let httpBody = try? JSONEncoder().encode(anonymousPushTokenBean) else {
            completion(CharalarmError.clientError)
            return
        }
        request.httpBody = httpBody
        
        
        print("****")
        print(request.curlString)
        print("****")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("クライアントサイドエラー: \(error.localizedDescription)")
                completion(CharalarmError.clientError)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(CharalarmError.serverError)
                return
            }
            print(data)
            
            if response.statusCode == 200 {
                completion(nil)
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
                print(#file)
                print(#function)
                print(#line)
                completion(CharalarmError.serverError)
            }
        }
        task.resume()
    }
}
