import Foundation

struct APIClient<ResponseType: Decodable> {
    
//    func xxx<ResponseType2: Decodable>() -> ResponseType2 {
//        return try! JSONDecoder().decode(ResponseType2.self, from: Data())
//    }
//
//
//    func request3<ResponseType2: Decodable>(url: URL, httpMethod: HttpMethod, requestHeader: [String: String], requestBody: Encodable?) async throws -> ResponseType2 {
//
//    }

    
    func request2(url: URL, httpMethod: HttpMethod, requestHeader: [String: String], requestBody: Encodable?) async throws -> ResponseType {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = requestHeader
        if let requestBody = requestBody, let httpBody = try? JSONEncoder().encode(requestBody) {
            urlRequest.httpBody = httpBody
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
        
        print("====== curl =====")
        print(urlRequest.curlString)
        print("=================")
        
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            throw CharalarmError.clientError
        }
                
        guard urlResponse.statusCode == 200 else {
            print(urlResponse.statusCode)
            if let response = try? JSONDecoder().decode(MessageResponse.self, from: data) {
                print(response)
                throw CharalarmError.clientError
            }
            
            throw CharalarmError.clientError
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(ResponseType.self, from: data)
        return response
    }
    
    func request3<T: Decodable>(url: URL, httpMethod: HttpMethod, requestHeader: [String: String], requestBody: Encodable?) async throws -> T {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = requestHeader
        if let requestBody = requestBody, let httpBody = try? JSONEncoder().encode(requestBody) {
            urlRequest.httpBody = httpBody
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
        
        print("====== curl =====")
        print(urlRequest.curlString)
        print("=================")
        
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            throw CharalarmError.clientError
        }
                
        guard urlResponse.statusCode == 200 else {
            print(urlResponse.statusCode)
            if let response = try? JSONDecoder().decode(MessageResponse.self, from: data) {
                print(response)
                throw CharalarmError.clientError
            }
            
            throw CharalarmError.clientError
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(T.self, from: data)
        return response
    }
    
    
    
    func fileDownload(url: URL) async throws -> Data {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethod.get.rawValue
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
        
        print("====== curl =====")
        print(urlRequest.curlString)
        print("=================")
        
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            throw CharalarmError.clientError
        }
                
        guard urlResponse.statusCode == 200 else {
            throw CharalarmError.clientError
        }
        
        return data
    }
}



struct APIClient2 {
    func downloadFile(url: URL) async throws -> Data {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethod.get.rawValue
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
        
        print("====== curl =====")
        print(urlRequest.curlString)
        print("=================")
        
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            throw CharalarmError.clientError
        }
                
        guard urlResponse.statusCode == 200 else {
            throw CharalarmError.clientError
        }
        
        return data
    }
    
    
    
    
    func request<ResponseType: Decodable>(url: URL, httpMethod: HttpMethod, requestHeader: [String: String], requestBody: Encodable?) async throws -> ResponseType {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = requestHeader
        if let requestBody = requestBody, let httpBody = try? JSONEncoder().encode(requestBody) {
            urlRequest.httpBody = httpBody
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
        
        print("====== curl =====")
        print(urlRequest.curlString)
        print("=================")
        
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            throw CharalarmError.clientError
        }
                
        guard urlResponse.statusCode == 200 else {
            print(urlResponse.statusCode)
            if let response = try? JSONDecoder().decode(MessageResponse.self, from: data) {
                print(response)
                throw CharalarmError.clientError
            }
            
            throw CharalarmError.clientError
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(ResponseType.self, from: data)
        return response
    }
    
}
