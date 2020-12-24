import Foundation

class AlarmListViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    @Published var showingSheetForNew = false
    @Published var showingSheetForEdit = false
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func addAlarmButtonTapped() {
        if alarms.count < 3 {
            showingSheetForNew = true
        } else {
            self.alertMessage = "アラームは最大3つまで作成できます。"
            self.showingAlert = true
        }
    }
    
    func createNewAlarm() -> Alarm {
        let date = Date()
        let calendar = Calendar.current
        let enable = true
        let name = date.description
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let dayOfWeeks: [DayOfWeek] = [.MON, .TUE, .WED, .THU, .FRI, .SAT, .SUN]
        return Alarm(alarmId: nil, enable: enable, name: name, hour: hour, minute: minute, dayOfWeeks: dayOfWeeks)
    }
    
    func fetchAlarms() {
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = KeychainHandler.getAnonymousUserPassword() else {
            self.alertMessage = "ユーザー情報の取得に失敗しました。"
            self.showingAlert = true
            return
        }
        AlarmStore.fetchAnonymousAlarms(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword) { result in
            switch result {
            case let .success(alarms):
                self.alarms = alarms
            case let .failure(error):
                self.showingAlert = true
                self.alertMessage = error.localizedDescription
            }
        }
    }
    
    func updateAlarmEnable(alarmId: Int, isEnable: Bool) {
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = KeychainHandler.getAnonymousUserPassword() else {
            self.alertMessage = "ユーザー情報の取得に失敗しました。"
            self.showingAlert = true
            return
        }
        
        guard let index = alarms.firstIndex(where: { $0.alarmId == alarmId }) else {
            return
        }
        
        alarms[index].enable = isEnable
        let alarm = alarms[index]
        AlarmStore.editAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { result in
            switch result {
            case .success(_):
                self.alertMessage = "編集完了しました"
                self.showingAlert = true
            case let .failure(error):
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
    }
}
