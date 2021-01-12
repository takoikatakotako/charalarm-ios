import Foundation

class ResourceStore {
    static func downloadSelfIntroduction(charaDomain: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: ResourceHandler.getSelfIntroductionUrlString(charaDomain: charaDomain))!
        let request = URLRequest(url: url)
        NetworkClient.request(urlRequest: request) { result in
            switch result {
            case let .success(data):
                do {
                    try FileHandler.saveFile(directoryName: charaDomain, fileName: "self-introduction.caf", data: data)
                    completion(.success("自己紹介の保存に成功しました"))
                } catch {
                    let message = """
                ファイル保存に失敗
                File: \(#file)
                Function: \(#function)
                Line: \(#line)
                """
                    print(message)
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func loadSelfIntroductionData(charaDomain: String, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            let data = try FileHandler.loadData(directoryName: charaDomain, fileName: "self-introduction.caf")
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
    
    static func downloadResourceJson(charaDomain: String, completion: @escaping (Result<Resource, Error>) -> Void) {
        let path = "/\(charaDomain)/resource.json"
        let urlRequest = APIRequest.createUrlRequest(baseUrl: RESOURCE_ENDPOINT, path: path, httpMethod: .get)
        let apiClient = APIClient<Resource>()
        apiClient.request(urlRequest: urlRequest) { result in
            switch result {
            case let .success(response):
                do {
                    let encoder = JSONEncoder()
                    let data = try encoder.encode(response)
                    try FileHandler.saveFile(directoryName: charaDomain, fileName: "resource.json", data: data)
                    completion(.success(response))
                } catch {
                    let message = """
                ファイル保存に失敗
                File: \(#file)
                Function: \(#function)
                Line: \(#line)
                """
                    print(message)
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    static func downloadResource(charaDomain: String, directory: String, fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "\(RESOURCE_ENDPOINT)/\(charaDomain)/\(directory)/\(fileName)"
        let url = URL(string: path)!
        let request = URLRequest(url: url)
        NetworkClient.request(urlRequest: request) { result in
            switch result {
            case let .success(data):
                do {
                    try FileHandler.saveFile(directoryName: charaDomain, fileName: fileName, data: data)
                    completion(.success("\(path)の保存に成功しました"))
                } catch {
                    let message = """
                ファイル保存に失敗
                File: \(#file)
                Function: \(#function)
                Line: \(#line)
                """
                    print(message)
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
