import Foundation

struct DiscordRepository {
    func sendMessageForContact(requestBody: DiscordRequest) async throws {
        let path = "/chara/list"
        let url = URL(string: "https://discord.com/api/webhooks/1226887562564603984/H9vDDO4rLPR9sytMZLDMXj-n9WhzVpAoUc-_F8O-uWDWZDhuAoTE7Q2UZQ5M0Gw0LK_9")!
        let requestHeader: [String: String] = APIHeader.defaultHeader
        let requestBody: Encodable? = requestBody
        let _: MessageResponse = try await APIClient().request(url: url, httpMethod: .post, requestHeader: requestHeader, requestBody: requestBody)
    }
}
