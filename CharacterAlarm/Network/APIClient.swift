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
    
    func request2(url: URL, httpMethod: HttpMethod, requestHeader: [String: String], requestBody: Encodable?) async throws -> ResponseType {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = requestHeader
        if let requestBody = requestBody, let httpBody = try? JSONEncoder().encode(requestBody) {
            urlRequest.httpBody = httpBody
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
        
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            throw CharalarmError.clientError
        }
        
        guard urlResponse.statusCode == 200 else {
            throw CharalarmError.clientError
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(ResponseType.self, from: data)
        return response
    }
    
    
    func request(urlRequest: URLRequest) async throws -> ResponseType {
        let data = try await NetworkClient.request(urlRequest: urlRequest)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let apiResponse: ResponseType = try decoder.decode(ResponseType.self, from: data)
        return apiResponse
    }
}
