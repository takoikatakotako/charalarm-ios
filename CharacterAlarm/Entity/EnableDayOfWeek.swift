struct EnableDayOfWeek {
    var sunday: Bool
    var monday: Bool
    var tuesday: Bool
    var wednesday: Bool
    var thursday: Bool
    var friday: Bool
    var saturday: Bool

    subscript(dayOfWeek: DayOfWeek) -> Bool {
        get {
            switch dayOfWeek {
            case .sunday:
                return sunday
            case .monday:
                return monday
            case .tuesday:
                return tuesday
            case .wednesday:
                return wednesday
            case .thursday:
                return thursday
            case .friday:
                return friday
            case .saturday:
                return saturday
            }
        }
        set(isEnable) {
            switch dayOfWeek {
            case .sunday:
                sunday = isEnable
            case .monday:
                monday = isEnable
            case .tuesday:
                tuesday = isEnable
            case .wednesday:
                wednesday = isEnable
            case .thursday:
                thursday = isEnable
            case .friday:
                friday = isEnable
            case .saturday:
                saturday = isEnable
            }
        }
    }
}
