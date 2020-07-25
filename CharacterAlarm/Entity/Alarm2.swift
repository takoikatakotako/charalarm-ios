import Foundation

struct Alarm2: Identifiable, Decodable, Hashable {
    let id: String
    let hour: Int
    let minute: Int
}
