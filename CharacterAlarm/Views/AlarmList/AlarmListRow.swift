import SwiftUI

protocol AlarmListRowDelegate {
    func updateAlarmEnable(alarmId: String, isEnable: Bool)
}

//class AlarmListRowModel: ObservableObject {
//    let alarmId: Int
//    let delegate: AlarmListRowDelegate
//    @Published var isEnable: Bool {
//        didSet {
//            self.delegate.updateAlarmEnable(alarmId: alarmId, isEnable: isEnable)
//        }
//    }
//
//    init (alarmId: String, isEnable: Bool, delegate: AlarmListRowDelegate) {
//        self.alarmId = alarmId
//        self.delegate = delegate
//        self.isEnable = isEnable
//    }
//}
//
//struct AlarmListRow: View {
//    @ObservedObject var alarmListModel: AlarmListRowModel
//    let alarm: Alarm2
//
//    init(delegate: AlarmListRowDelegate, alarm: Alarm2) {
//        self.alarmListModel = AlarmListRowModel(alarmId: alarm.id, isEnable: alarm.enable, delegate: delegate)
//        self.alarm = alarm
//    }
//
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text("\(alarm.hour + alarm.timeDifference):\(alarm.minute)")
//                    .font(Font.system(size: 20))
//                Text("アラーム名")
//                Text("毎日")
//            }
//            Spacer()
//            Toggle(isOn: $alarmListModel.isEnable) {
//                Text("")
//            }.padding()
//        }
//    }
//}

struct MockAlarmListRowDelegate: AlarmListRowDelegate {
    func updateAlarmEnable(alarmId: String, isEnable: Bool) {}
}

//struct AlarmListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmListRow(delegate: MockAlarmListRowDelegate(), alarm: Alarm(uid: "uid", token: ""))
//            .previewLayout(
//                .fixed(width: 320, height: 60))
//    }
//}
