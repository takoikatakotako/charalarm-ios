import Foundation
class AlarmListViewModel: ObservableObject {
    let model: AlarmListModel
    let uid: String
    @Published var alarms: [Alarm] = []

    init(uid: String) {
        self.uid = uid
        self.model = AlarmListModel()
    }

    func onAppear() {
        model.featchAlarms(uid: "user.uid") { (alarms, _) in
            self.alarms = alarms
        }
    }

    func deleteAlarm(at offsets: IndexSet) {
        for offset in offsets {
            let alarmId = alarms[offset].id
            model.deleteAlarm(uid: uid, alarmId: alarmId) { error in
                if let error = error {
                    print(error)
                }
            }
        }
        alarms.remove(atOffsets: offsets)
    }

    func updateAlarmEnable(alarmId: String, isEnable: Bool) {
        guard let index = alarms.firstIndex(where: { $0.id == alarmId}) else {
            return
        }

        alarms[index].isEnable = isEnable
        AlarmStore.save(alarm: alarms[index]) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
