import Foundation

enum DayOfWeek: String, Codable, CaseIterable {
    case MON = "MON"
    case TUE = "TUE"
    case WED = "WED"
    case THU = "THU"
    case FRI = "FRI"
    case SAT = "SAT"
    case SUN = "SUN"
}

extension DayOfWeek: Identifiable {
    var id: DayOfWeek { self }
}
