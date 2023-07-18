import SwiftUI

struct AlarmDetailWeekdaySelecter: View {
    @Binding var alarm: Alarm
    var body: some View {
        HStack {
            AlarmDetailWeekdayButton(enable: $alarm.sunday, title: R.string.localizable.dayOfWeekSunday())
            AlarmDetailWeekdayButton(enable: $alarm.monday, title: R.string.localizable.dayOfWeekMonday())
            AlarmDetailWeekdayButton(enable: $alarm.tuesday, title: R.string.localizable.dayOfWeekTuesday())
            AlarmDetailWeekdayButton(enable: $alarm.wednesday, title: R.string.localizable.dayOfWeekWednesday())
            AlarmDetailWeekdayButton(enable: $alarm.thursday, title: R.string.localizable.dayOfWeekThursday())
            AlarmDetailWeekdayButton(enable: $alarm.friday, title: R.string.localizable.dayOfWeekFriday())
            AlarmDetailWeekdayButton(enable: $alarm.saturday, title: R.string.localizable.dayOfWeekSaturday())
        }
    }
}


//struct AlarmDetailWeekdaySelecter_Previews: PreviewProvider {
//    struct PreviewWrapper: View {
//        @State var dayOfWeeks: [DayOfWeek] = [.MON, .WED, .FRI, .SUN]
//
//        var body: some View {
//            AlarmDetailWeekdaySelecter(dayOfWeeks: $dayOfWeeks)
//        }
//    }
//
//    static var previews: some View {
//        PreviewWrapper()
//            .previewLayout(.sizeThatFits)
//    }
//}
