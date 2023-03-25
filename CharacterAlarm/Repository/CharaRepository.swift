import UIKit

class CharaRepository {
    func fetchCharacters() async throws -> [Character] {
        let path = "/chara/list"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = nil
        let charaResponses = try await APIClient<[CharaResponse]>().request2(url: url, httpMethod: .get, requestHeader: requestHeader, requestBody: requestBody)        
        return charaResponses.map { Character(charaResponse: $0) }
    }
    
    func fetchCharacter(charaId: String) async throws -> Character {
        let path = "/chara/id/\(charaId)"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = nil
        let charaResponse = try await APIClient<CharaResponse>().request2(url: url, httpMethod: .get, requestHeader: requestHeader, requestBody: requestBody)
        return Character(charaResponse: charaResponse)
    }
}
