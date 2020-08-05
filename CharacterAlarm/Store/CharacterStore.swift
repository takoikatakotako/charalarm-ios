import UIKit

class CharacterStore {
    static func fetchCharacters(completion: @escaping (Error?, [Character]) -> Void) {
        let url = URL(string: BASE_URL + "/api/chara/list")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
        request.allHTTPHeaderFields = header
        
        print("****")
        print(request.curlString)
        print("****")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("クライアントサイドエラー: \(error.localizedDescription)")
                completion(CharalarmError.clientError, [])
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(CharalarmError.serverError, [])
                return
            }
            
            if response.statusCode == 200 {
                guard let jsonResponse = try? JSONDecoder().decode(JsonResponseBean<[Character]>.self, from: data) else {
                    completion(CharalarmError.parseError, [])
                    return
                }
                completion(nil, jsonResponse.data)
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
                print(#file)
                print(#function)
                print(#line)
                completion(CharalarmError.serverError, [])
            }
        }
        task.resume()
    }
    
    
    static func fetchCharacter(charaDomain: String, completion: @escaping (Error?, Character?) -> Void) {
        let url = URL(string: BASE_URL + "/api/chara/domain/\(charaDomain)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
        request.allHTTPHeaderFields = header
        
        print("****")
        print(request.curlString)
        print("****")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("クライアントサイドエラー: \(error.localizedDescription)")
                completion(CharalarmError.clientError, nil)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(CharalarmError.serverError, nil)
                return
            }
            
            if response.statusCode == 200 {
                guard let jsonResponse = try? JSONDecoder().decode(JsonResponseBean<Character>.self, from: data) else {
                    completion(CharalarmError.parseError, nil)
                    return
                }
                completion(nil, jsonResponse.data)
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
                print(#file)
                print(#function)
                print(#line)
                completion(CharalarmError.serverError, nil)
            }
        }
        task.resume()
    }
}
