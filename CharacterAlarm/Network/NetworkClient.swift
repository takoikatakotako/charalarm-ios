import Foundation

struct NetworkClient {
    static func request(urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        print("====== curl =====")
        print(urlRequest.curlString)
        print("=================")
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                let message = """
                クライアントエラー(\(error.localizedDescription))
                File: \(#file)
                Function: \(#function)
                Line: \(#line)
                """
                print(message)
                completion(.failure(CharalarmError.clientError))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                let message = """
                サーバーエラー
                File: \(#file)
                Function: \(#function)
                Line: \(#line)
                """
                print(message)
                completion(.failure(CharalarmError.serverError))
                return
            }
            
            print("====== response =====")
            print(String(decoding: data, as: UTF8.self))
            print("=================")
            
            if response.statusCode == 200 {
                completion(.success(data))
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                let message = """
                レスポンスコードエラー
                File: \(#file)
                Function: \(#function)
                Line: \(#line)
                """
                print(message)
                completion(.failure(CharalarmError.serverError))
            }
        }
        task.resume()
    }
}
