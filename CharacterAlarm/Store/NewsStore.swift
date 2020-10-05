import Foundation

class NewsStore {
    static func fetchNews(completion: @escaping (Result<[News], Error>) -> Void) {
        let path = "/api/news/list"
        let urlRequest = APIRequest.createUrlRequest(path: path)
        let apiClient = APIClient<JsonResponseBean<[News]>>()
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
