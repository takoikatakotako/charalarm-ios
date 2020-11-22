import Foundation

struct APIClient<ResponseType: Decodable> {
    func request(urlRequest: URLRequest, completion: @escaping (Result<ResponseType, Error>) -> Void) {
        NetworkClient.request(urlRequest: urlRequest) { result in
            switch result {
            case let .success(data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let apiResponse: ResponseType = try decoder.decode(ResponseType.self, from: data)
                    completion(.success(apiResponse))
                } catch {
                    print(error)
                    completion(.failure(CharalarmError.decode))
                    return
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
