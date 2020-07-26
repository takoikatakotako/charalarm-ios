import Foundation


struct AnonymousAlarmBean: Encodable {
    let anonymousUserName: String
    let password: String

    let enable: Bool
    let name: String
    let hour: Int
    let minute: Int
    let dayOfWeeks: [DayOfWeek2]
}
