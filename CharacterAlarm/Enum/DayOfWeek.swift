enum DayOfWeek: String, CaseIterable {
    case sunday = "日"
    case monday = "月"
    case tuesday = "火"
    case wednesday = "水"
    case thursday = "木"
    case friday = "金"
    case saturday = "土"
}

extension DayOfWeek: Identifiable {
    var id: DayOfWeek { self }
}
