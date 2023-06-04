import Foundation

class ResourceStore {
    // 本当はここに定義しちゃダメ
    static let resourceHandler = ResourceRepository()
    static let fileHandler = FileRepository()
    
    
    static func downloadSelfIntroduction(charaDomain: String) async throws {
        let url = URL(string: resourceHandler.getSelfIntroductionUrlString(charaDomain: charaDomain))!
        let data = try await APIClient<String>().fileDownload(url: url)
        try fileHandler.saveFile(directoryName: charaDomain, fileName: "self-introduction.caf", data: data)
    }
    
    static func loadSelfIntroductionData(charaDomain: String) async throws -> Data {
        let data = try fileHandler.loadData(directoryName: charaDomain, fileName: "self-introduction.caf")
        return data
    }
    
    static func downloadResourceJson(charaDomain: String) async throws -> Resource {
        let path = "/\(charaDomain)/resource.json"
        let url = URL(string: environmentVariable.apiEndpoint + path)!
        let data = try await APIClient<String>().fileDownload(url: url)
        let response = try JSONDecoder().decode(Resource.self, from: data)
        try fileHandler.saveFile(directoryName: charaDomain, fileName: "resource.json", data: data)
        return response
    }
    
    
    static func downloadResource(charaDomain: String, directory: String, fileName: String) async throws {
        let path = "\(environmentVariable.resourceEndpoint)/\(charaDomain)/\(directory)/\(fileName)"
        let url = URL(string: path)!
        let data = try await APIClient<String>().fileDownload(url: url)
        try fileHandler.saveFile(directoryName: charaDomain, fileName: fileName, data: data)
    }
}
