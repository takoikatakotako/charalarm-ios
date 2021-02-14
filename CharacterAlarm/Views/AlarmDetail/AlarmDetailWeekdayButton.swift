import SwiftUI

struct AlarmDetailWeekdayButton: View {
    @Binding var dayOfWeeks: [DayOfWeek]
    let dayOfWeek: DayOfWeek
    
    var isOn: Bool {
        return dayOfWeeks.contains(dayOfWeek)
    }
    
    var title: String {
        switch dayOfWeek {
        case .MON:
            return R.string.localizable.dayOfWeekMonday()
        case .TUE:
            return R.string.localizable.dayOfWeekTuesday()
        case .WED:
            return R.string.localizable.dayOfWeekWednesday()
        case .THU:
            return R.string.localizable.dayOfWeekThursday()
        case .FRI:
            return R.string.localizable.dayOfWeekFriday()
        case .SAT:
            return R.string.localizable.dayOfWeekSaturday()
        case .SUN:
            return R.string.localizable.dayOfWeekSunday()
        }
    }
    
    var body: some View {
        Button(action: {
            if isOn {
                if let index = dayOfWeeks.firstIndex(of: dayOfWeek) {
                    dayOfWeeks.remove(at: index)
                }
            } else {
                dayOfWeeks.append(dayOfWeek)
            }
            
        }) {
            Text(title)
                .font(Font.system(size: 16).bold())
                .foregroundColor(isOn ? Color.white : Color.black)
                .frame(width: 40, height: 40)
                .background(isOn ? Color(R.color.alarmCardBackgroundGreen.name) : Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(R.color.alarmCardBackgroundGreen.name), lineWidth: 2)
                )
        }
    }
}

struct AlarmDetailWeekdayButton_Previews: PreviewProvider {
    struct PreviewWrapperOn: View {
        @State var dayOfWeeks: [DayOfWeek] = [.MON]
        var body: some View {
            AlarmDetailWeekdayButton(dayOfWeeks: $dayOfWeeks, dayOfWeek: .MON)
        }
    }
    
    struct PreviewWrapperOff: View {
        @State var dayOfWeeks: [DayOfWeek] = [.MON]
        var body: some View {
            AlarmDetailWeekdayButton(dayOfWeeks: $dayOfWeeks, dayOfWeek: .THU)
        }
    }
    
    static var previews: some View {
        Group {
            PreviewWrapperOn()
                .previewLayout(.sizeThatFits)
            PreviewWrapperOff()
                .previewLayout(.sizeThatFits)
        }
    }
}
