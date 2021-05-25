import UIKit

class CharaCallRepository {
    func findByCharaCallId(charaCallId: Int, completion: @escaping (Result<CharaCallResponseEntity, Error>) -> Void) {
        let path = "/api/chara-call/\(charaCallId)"
        let urlRequest = APIRequest.createUrlRequest(path: path)
        let apiClient = APIClient<JsonResponseBean<CharaCallResponseEntity>>()
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
