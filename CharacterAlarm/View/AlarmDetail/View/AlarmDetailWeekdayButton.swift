import SwiftUI

struct AlarmDetailWeekdayButton: View {
    @Binding var enable: Bool
    let title: String

    var body: some View {
        Button(action: {
            enable.toggle()
        }) {
            Text(title)
                .font(Font.system(size: 16).bold())
                .foregroundColor(enable ? Color.white : Color.black)
                .frame(width: 40, height: 40)
                .background(enable ? Color(R.color.alarmCardBackgroundGreen.name) : Color.white)
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
        var body: some View {
            AlarmDetailWeekdayButton(enable: .constant(true), title: R.string.localizable.dayOfWeekMonday())
        }
    }

    struct PreviewWrapperOff: View {
        var body: some View {
            AlarmDetailWeekdayButton(enable: .constant(false), title: R.string.localizable.dayOfWeekMonday())        }
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
