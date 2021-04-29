import UIKit

class CharaRepository {
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        let path = "/api/chara/list"
        let urlRequest = APIRequest.createUrlRequest(path: path)
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
    
    func fetchCharacter(charaId: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        let path = "/api/chara/\(charaId)"
        let urlRequest = APIRequest.createUrlRequest(path: path)
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
    }
    
    func fetchCharacter(charaDomain: String, completion: @escaping (Result<Character, Error>) -> Void) {
        let path = "/api/chara/domain/\(charaDomain)"
        let urlRequest = APIRequest.createUrlRequest(path: path)
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
    }
}