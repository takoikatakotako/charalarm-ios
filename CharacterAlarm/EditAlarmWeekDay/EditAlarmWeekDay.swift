import SwiftUI

enum DayOfWeek: String, CaseIterable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case Saturday
}

extension DayOfWeek: Identifiable {
    var id: DayOfWeek { self }
}

struct EditAlarmWeekDay: View {
    var body: some View {
        List(DayOfWeek.allCases) { dayOfWeek in
            Button(action: {
                print(dayOfWeek.rawValue)
            }, label: {
                HStack {
                    Text("\(dayOfWeek.rawValue)")
                    Spacer()
                    Text("✔︎")
                }
            })
        }
    }
}

struct EditAlarmWeekDay_Previews: PreviewProvider {
    static var previews: some View {
        EditAlarmWeekDay()
    }
}
