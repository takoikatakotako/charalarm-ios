enum DayOfWeek: String, CaseIterable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

extension DayOfWeek: Identifiable {
    var id: DayOfWeek { self }
}
