import Foundation

struct News: Decodable, Identifiable {
    let id = UUID()
    let newsId: Int
    let siteName: String
    let url: String
    let title: String
    let description: String
    // Date でパースしたい
    let registeredAt: String
}
