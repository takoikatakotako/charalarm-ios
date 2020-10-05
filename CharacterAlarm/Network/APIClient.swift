import Foundation

struct APIClient<ResponseType: Decodable> {
    func request(urlRequest: URLRequest, completion: @escaping (Result<ResponseType, Error>) -> Void) {
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
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let apiResponse: ResponseType = try? decoder.decode(ResponseType.self, from: data) else {
                    let message = """
                    デコードエラー
                    File: \(#file)
                    Function: \(#function)
                    Line: \(#line)
                    """
                    print(message)
                    completion(.failure(CharalarmError.decode))
                    return
                }
                completion(.success(apiResponse))
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
