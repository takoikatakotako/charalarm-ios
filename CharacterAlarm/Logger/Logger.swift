import Foundation

struct Logger {
    func sendLog(message: String) {
        let url = URL(string: "https://http-intake.logs.datadoghq.com/v1/input")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["DD-API-KEY": "e82a46be5b8f7aa6ac41e8ec4cb4eec2", "Content-Type": "application/json"]
        
        struct DatadogInfo: Codable {
            let host: String
            let source: String
            let service: String
            let status: String
            let message: String
        }
  
        let info = DatadogInfo(host: "charalarm-ios", source: "iOS", service: "iOS", status: "Info", message: message)
        request.httpBody = try! JSONEncoder().encode(info)
        
        
        print(request.curlString)
        

        let task = URLSession.shared.dataTask(with: request) { _, _, _ in }

        task.resume()
    }
}

