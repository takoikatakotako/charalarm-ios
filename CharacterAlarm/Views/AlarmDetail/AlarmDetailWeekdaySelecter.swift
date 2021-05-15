import SwiftUI

struct AlarmDetailWeekdaySelecter: View {
    @Binding var dayOfWeeks: [DayOfWeek]
    var body: some View {
        HStack {
            AlarmDetailWeekdayButton(dayOfWeeks: $dayOfWeeks, dayOfWeek: .MON)
            AlarmDetailWeekdayButton(dayOfWeeks: $dayOfWeeks, dayOfWeek: .TUE)
            AlarmDetailWeekdayButton(dayOfWeeks: $dayOfWeeks, dayOfWeek: .WED)
            AlarmDetailWeekdayButton(dayOfWeeks: $dayOfWeeks, dayOfWeek: .THU)
            AlarmDetailWeekdayButton(dayOfWeeks: $dayOfWeeks, dayOfWeek: .FRI)
            AlarmDetailWeekdayButton(dayOfWeeks: $dayOfWeeks, dayOfWeek: .SAT)
            AlarmDetailWeekdayButton(dayOfWeeks: $dayOfWeeks, dayOfWeek: .SUN)
        }
    }
}

struct AlarmDetailWeekdaySelecter_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State var dayOfWeeks: [DayOfWeek] = [.MON, .WED, .FRI, .SUN]

        var body: some View {
            AlarmDetailWeekdaySelecter(dayOfWeeks: $dayOfWeeks)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
            .previewLayout(.sizeThatFits)
    }
}
