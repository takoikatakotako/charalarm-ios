import Foundation

class ResourceStore {
    static func downloadSelfIntroduction(charaDomain: String) async throws {
        let url = URL(string: charalarmEnvironment.resourceHandler.getSelfIntroductionUrlString(charaDomain: charaDomain))!
        let data = try await APIClient<String>().fileDownload(url: url)
        try charalarmEnvironment.fileHandler.saveFile(directoryName: charaDomain, fileName: "self-introduction.caf", data: data)
    }
    
    static func loadSelfIntroductionData(charaDomain: String) async throws -> Data {
        let data = try charalarmEnvironment.fileHandler.loadData(directoryName: charaDomain, fileName: "self-introduction.caf")
        return data
    }
    
    static func downloadResourceJson(charaDomain: String) async throws -> Resource {
        let path = "/\(charaDomain)/resource.json"
        let url = URL(string: API_ENDPOINT + path)!
        let data = try await APIClient<String>().fileDownload(url: url)
        let response = try JSONDecoder().decode(Resource.self, from: data)
        try charalarmEnvironment.fileHandler.saveFile(directoryName: charaDomain, fileName: "resource.json", data: data)
        return response
    }
    
    
    static func downloadResource(charaDomain: String, directory: String, fileName: String) async throws {
        let path = "\(RESOURCE_ENDPOINT)/\(charaDomain)/\(directory)/\(fileName)"
        let url = URL(string: path)!
        let data = try await APIClient<String>().fileDownload(url: url)
        try charalarmEnvironment.fileHandler.saveFile(directoryName: charaDomain, fileName: fileName, data: data)
    }
}
