import UIKit

class CharacterStore {
    static func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        let path = "/api/chara/list"
        let urlRequest = APIRequest2.toUrlRequest(path: path)
        let apiClient = APIClient<JsonResponseBean<[Character]>>()
        apiClient.request(urlRequest: urlRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    completion(.success(response.data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func fetchCharacter(charaDomain: String, completion: @escaping (Result<Character, Error>) -> Void) {
        let path = "/api/chara/domain/\(charaDomain)"
        let urlRequest = APIRequest2.toUrlRequest(path: path)
        let apiClient = APIClient<JsonResponseBean<Character>>()
        apiClient.request(urlRequest: urlRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    completion(.success(response.data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
        
        
        
//        let url = URL(string: BASE_URL + "/api/chara/domain/\(charaDomain)")!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
//        request.allHTTPHeaderFields = header
//
//        print("****")
//        print(request.curlString)
//        print("****")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("クライアントサイドエラー: \(error.localizedDescription)")
//                completion(CharalarmError.clientError, nil)
//                return
//            }
//
//            guard let data = data, let response = response as? HTTPURLResponse else {
//                completion(CharalarmError.serverError, nil)
//                return
//            }
//
//            if response.statusCode == 200 {
//                guard let jsonResponse = try? JSONDecoder().decode(JsonResponseBean<Character>.self, from: data) else {
//                    completion(CharalarmError.decode, nil)
//                    return
//                }
//                completion(nil, jsonResponse.data)
//            } else {
//                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
//                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
//                print(#file)
//                print(#function)
//                print(#line)
//                completion(CharalarmError.serverError, nil)
//            }
//        }
//        task.resume()
    }
}
