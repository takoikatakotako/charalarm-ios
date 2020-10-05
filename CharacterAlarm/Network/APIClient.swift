import Foundation

struct APIClient {
    func request<RequestBody: Encodable, ResponseType: Decodable>(path: String, httpMethod: HttpMethod, requestHeader: [String: String], requestBody: RequestBody, completion: @escaping (Result<ResponseType, Error>) -> Void) {
        let url = URL(string: BASE_URL + path)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = requestHeader
        
        guard let httpBody = try? JSONEncoder().encode(requestBody) else {
            let message = """
            エンコードエラー
            File: \(#file)
            Function: \(#function)
            Line: \(#line)
            """
            print(message)
            completion(.failure(CharalarmError.encode))
            return
        }
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
            
            if response.statusCode == 200 {
                guard let apiResponse: ResponseType = try? JSONDecoder().decode(ResponseType.self, from: data) else {
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

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
