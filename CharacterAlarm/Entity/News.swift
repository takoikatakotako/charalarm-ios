import Foundation

struct News: Decodable, Identifiable {
    var id: Int {
        return newsId
    }
    let newsId: Int
    let siteName: String
    let url: String
    let title: String
    let description: String
    // Date でパースしたい
    let registeredAt: String
}
