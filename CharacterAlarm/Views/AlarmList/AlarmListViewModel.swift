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
        let dayOfWeeks: [DayOfWeek] = [.MON, .TUE, .WED, .THU, .FRI, .SAT, .SUN]
        return Alarm(alarmId: nil, enable: enable, name: name, hour: hour, minute: minute, dayOfWeeks: dayOfWeeks)
    }
    
    func fetchAlarms() {
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = KeychainHandler.getAnonymousUserPassword() else {
            self.showingAlert = true
            self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
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
            self.showingAlert = true
            self.alertMessage = "不明なエラーです（匿名ユーザー名とかがない）"
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
    
    func deleteAlarm(alarmId: Int) {
        guard let index = alarms.firstIndex(where: { $0.alarmId == alarmId}) else {
            self.showingAlert = true
            self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
            return
        }
        alarms.remove(at: index)
        
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = KeychainHandler.getAnonymousUserPassword() else {
            self.showingAlert = true
            self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
            return
        }
        AlarmStore.deleteAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarmId: alarmId) { result in
            switch result {
            case .success(_):
                self.alertMessage = "削除完了しました"
                self.showingAlert = true
            case let .failure(error):
                self.showingAlert = true
                self.alertMessage = error.localizedDescription
            }
        }
    }
}
