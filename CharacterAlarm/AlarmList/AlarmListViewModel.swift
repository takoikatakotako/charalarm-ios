import Foundation
class AlarmListViewModel: ObservableObject {
    let model: AlarmListModel
    let uid: String
    @Published var alarms: [Alarm] = []

    init(uid: String) {
        self.uid = uid
        self.model = AlarmListModel()

        model.featchAlarms(uid: "user.uid") { (alarms, _) in
            self.alarms = alarms
        }
    }
}
