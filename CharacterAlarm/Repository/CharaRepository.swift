import UIKit

class CharaRepository {
    func fetchCharacters() async throws -> [Character] {
        let path = "/api/chara/list"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = nil
        return try await APIClient<[Character]>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
    
    func fetchCharacter(charaId: Int) async throws -> Character {
        let path = "/api/chara/\(charaId)"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = nil
        return try await APIClient<Character>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
    
    func fetchCharacter(charaDomain: String) async throws -> Character {
        let path = "/api/chara/domain/\(charaDomain)"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = nil
        return try await APIClient<Character>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
}
