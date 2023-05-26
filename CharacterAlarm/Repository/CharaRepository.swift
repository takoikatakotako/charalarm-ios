import UIKit

class CharaRepository {
    func fetchCharacters() async throws -> [Chara] {
        let path = "/chara/list"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = nil
        let charaResponses = try await APIClient<[CharaResponse]>().request2(url: url, httpMethod: .get, requestHeader: requestHeader, requestBody: requestBody)        
        return charaResponses.map { Chara(charaResponse: $0) }
    }
    
    func fetchCharacter(charaID: String) async throws -> Chara {
        let path = "/chara/id/\(charaID)"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = nil
        let charaResponse = try await APIClient<CharaResponse>().request2(url: url, httpMethod: .get, requestHeader: requestHeader, requestBody: requestBody)
        return Chara(charaResponse: charaResponse)
    }
}
