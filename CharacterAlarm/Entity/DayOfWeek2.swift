import Foundation

enum DayOfWeek2: String, Codable, CaseIterable {
    case MON = "MON"
    case TUE = "TUE"
    case WED = "WED"
    case THU = "THU"
    case FRI = "FRI"
    case SAT = "SAT"
    case SUN = "SUN"
}

extension DayOfWeek2: Identifiable {
    var id: DayOfWeek2 { self }
}
