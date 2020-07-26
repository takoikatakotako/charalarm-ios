import SwiftUI

protocol AlarmListRowDelegate {
    func updateAlarmEnable(alarmId: Int, isEnable: Bool)
}

class AlarmListRowModel: ObservableObject {
    let alarmId: Int?
    let delegate: AlarmListRowDelegate?
    @Published var enable: Bool {
        didSet {
            guard let alarmId = alarmId else {
                return
            }
            self.delegate?.updateAlarmEnable(alarmId: alarmId, isEnable: enable)
        }
    }

    init (alarmId: Int?, enable: Bool, delegate: AlarmListRowDelegate) {
        self.enable = enable
        self.alarmId = alarmId
        self.delegate = delegate
    }
}

struct AlarmListRow: View {
     @ObservedObject var alarmListModel: AlarmListRowModel
    let alarm: Alarm

    init(delegate: AlarmListRowDelegate, alarm: Alarm) {
        self.alarm = alarm
        self.alarmListModel = AlarmListRowModel(alarmId: alarm.alarmId, enable: alarm.enable, delegate: delegate)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(alarm.hour):\(alarm.minute)")
                    .font(Font.system(size: 20))
                Text(alarm.name)
                Text(alarm.dayOfWeeksString)
            }
            Spacer()
            Toggle(isOn: $alarmListModel.enable) {
                Text("")
            }.padding()
        }
    }
}

struct MockAlarmListRowDelegate: AlarmListRowDelegate {
    func updateAlarmEnable(alarmId: Int, isEnable: Bool) {
        
    }
}

//struct AlarmListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmListRow(delegate: MockAlarmListRowDelegate(), alarm: Alarm(uid: "uid", token: ""))
//            .previewLayout(
//                .fixed(width: 320, height: 60))
//    }
//}
