import Foundation

class AlarmListViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func createNewAlarm() -> Alarm {
        let date = Date()
        let calendar = Calendar.current
        let enable = true
        let name = date.description
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let dayOfWeeks: [DayOfWeek2] = [.MON, .TUE, .WED, .THU, .FRI, .SAT, .SUN]
        return Alarm(alarmId: nil, enable: enable, name: name, hour: hour, minute: minute, dayOfWeeks: dayOfWeeks)
    }
    
    func fetchAlarms() {
        guard let anonymousUserName = UserDefaults.standard.string(forKey: ANONYMOUS_USER_NAME),
            let anonymousUserPassword = UserDefaults.standard.string(forKey: ANONYMOUS_USER_PASSWORD) else {
                self.showingAlert = true
                self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                return
        }
        AlarmStore.fetchAnonymousAlarms(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword) { error, alarms in
            if let error = error {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = error.localizedDescription
                }
                return
            }
            DispatchQueue.main.async {
                self.alarms = alarms
            }
        }
    }
    
    func updateAlarmEnable(alarmId: Int, isEnable: Bool) {
        guard let anonymousUserName = UserDefaults.standard.string(forKey: ANONYMOUS_USER_NAME),
            let anonymousUserPassword = UserDefaults.standard.string(forKey: ANONYMOUS_USER_PASSWORD) else {
                self.showingAlert = true
                self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                return
        }
        
        guard let index = alarms.firstIndex(where: { $0.alarmId == alarmId }) else {
            return
        }
        
        alarms[index].enable = isEnable
        let alarm = alarms[index]
        AlarmStore.editAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { error in
            if let error = error {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = error.localizedDescription
                }
                return
            }
            DispatchQueue.main.async {
                self.showingAlert = true
                self.alertMessage = "編集完了しました"
            }
        }
    }
    
    func deleteAlarm(alarmId: Int) {
        guard let index = alarms.firstIndex(where: { $0.alarmId == alarmId})else {
            return
        }
        alarms.remove(at: index)
        
        guard let anonymousUserName = UserDefaults.standard.string(forKey: ANONYMOUS_USER_NAME),
            let anonymousUserPassword = UserDefaults.standard.string(forKey: ANONYMOUS_USER_PASSWORD) else {
                self.showingAlert = true
                self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                return
        }
        AlarmStore.deleteAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarmId: alarmId) { error in
            if let error = error {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = error.localizedDescription
                }
                return
            }
            DispatchQueue.main.async {
                self.showingAlert = true
                self.alertMessage = "削除完了しました"
            }
        }
    }
}
