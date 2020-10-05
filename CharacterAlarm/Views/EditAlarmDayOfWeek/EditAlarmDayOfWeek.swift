import SwiftUI

protocol  EditAlarmDayOfWeekDelegate {
    func updateDayOfWeek(dayOfWeeks: [DayOfWeek])
}

struct EditAlarmDayOfWeek: View {
    let delegate: EditAlarmDayOfWeekDelegate
    @State var dayOfWeeks: [DayOfWeek]
    
    var body: some View {
        List(DayOfWeek.allCases) { dayOfWeek in
            Button(action: {
                if self.dayOfWeeks.contains(dayOfWeek) {
                    self.dayOfWeeks = self.dayOfWeeks.filter{ $0 != dayOfWeek }
                } else {
                    self.dayOfWeeks.append(dayOfWeek)
                }
            }, label: {
                HStack {
                    Text(self.dayOfWeekString(dayOfWeek: dayOfWeek))
                        .foregroundColor(Color.black)
                    Spacer()
                    if self.dayOfWeeks.contains(dayOfWeek) {
                        Text("✔︎")
                            .foregroundColor(Color.black)
                    }
                }
            })
        }.onDisappear {
            self.delegate.updateDayOfWeek(dayOfWeeks: self.dayOfWeeks)
        }
    }
    
    private func dayOfWeekString(dayOfWeek: DayOfWeek) -> String {
        switch dayOfWeek {
        case .MON:
            return "月"
        case .TUE:
            return "火"
        case .WED:
            return "水"
        case .THU:
            return "木"
        case .FRI:
            return "金"
        case .SAT:
            return "土"
        case .SUN:
            return "日"
        }
    }
}

struct MockEditAlarmDayOfWeekDelegate: EditAlarmDayOfWeekDelegate {
    func updateDayOfWeek(dayOfWeeks: [DayOfWeek]) {}
}
