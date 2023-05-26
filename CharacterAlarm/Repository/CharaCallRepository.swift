import UIKit

class CharaCallRepository {
    func findByCharaCallId(charaCallId: Int) async throws -> CharaCallResponseEntity {
        let path = "/api/chara-call/\(charaCallId)"
        let url = URL(string: API_ENDPOINT + path)!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = nil
        return try await APIClient<CharaCallResponseEntity>().request2(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
}
