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
                .background(isOn ? Color("alarm-card-background-green") : Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("alarm-card-background-green"), lineWidth: 2)
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
