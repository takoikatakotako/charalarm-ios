import SwiftUI

protocol  EditAlarmDayOfWeekDelegate {
    func updateDayOfWeek(enableDayOfWeek: EnableDayOfWeek)
}

struct EditAlarmDayOfWeek: View {
    let delegate: EditAlarmDayOfWeekDelegate
    @State var enableDayOfWeek: EnableDayOfWeek

    var body: some View {
        List(DayOfWeek.allCases) { dayOfWeek in
            Button(action: {
                self.enableDayOfWeek[dayOfWeek] = !self.enableDayOfWeek[dayOfWeek]
            }, label: {
                HStack {
                    Text("\(dayOfWeek.rawValue)")
                    Spacer()
                    if self.enableDayOfWeek[dayOfWeek] {
                        Text("✔︎")
                    }
                }
            })
        }.onDisappear {
            self.delegate.updateDayOfWeek(enableDayOfWeek: self.enableDayOfWeek)
        }
    }
}

struct MockEditAlarmDayOfWeekDelegate: EditAlarmDayOfWeekDelegate {
    func updateDayOfWeek(enableDayOfWeek: EnableDayOfWeek) {}
}

struct EditAlarmWeekDay_Previews: PreviewProvider {
    static var previews: some View {
        EditAlarmDayOfWeek(delegate: MockEditAlarmDayOfWeekDelegate(), enableDayOfWeek:
            EnableDayOfWeek(
                sunday: true,
                monday: false,
                tuesday: true,
                wednesday: false,
                thursday: true,
                friday: false,
                saturday: true)
        )
    }
}
