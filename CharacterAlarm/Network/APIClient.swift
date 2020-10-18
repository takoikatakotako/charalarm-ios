import Foundation

struct APIClient<ResponseType: Decodable> {
    func request(urlRequest: URLRequest, completion: @escaping (Result<ResponseType, Error>) -> Void) {
        NetworkClient.request(urlRequest: urlRequest) { result in
            switch result {
            case let .success(data):
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
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
