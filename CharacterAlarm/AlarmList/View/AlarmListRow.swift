import SwiftUI

struct AlarmListRow: View {
    @State private var showGreeting = true
    let alarm: Alarm
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(alarm.hour + alarm.timeDifference):\(alarm.minute)")
                    .font(Font.system(size: 20))
                Text("アラーム名")
                Text("毎日")
            }
            Spacer()
            Toggle(isOn: $showGreeting) {
                Text("")
            }.padding()
        }
    }
}

struct AlarmListRow_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListRow(alarm: Alarm(uid: "uid", token: ""))
            .previewLayout(
                .fixed(width: 320, height: 60))
    }
}
