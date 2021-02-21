import Foundation

class AlarmListViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    
    @Published var showingEditAlarmSheet = false
    var selectedAlarm: Alarm?
    
    @Published var showingAlert = false
    var alertMessage = ""
    
    func addAlarmButtonTapped() {
        if alarms.count < 3 {
            editAlarm(alarm: createNewAlarm())
        } else {
            self.alertMessage = R.string.localizable.alarmYouCanCreateUpToThreeAlarms()
            self.showingAlert = true
        }
    }
    
    func createNewAlarm() -> Alarm {
        let date = Date()
        let name = R.string.localizable.alarmNewAlarm()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let enable = true
        let dayOfWeeks: [DayOfWeek] = [.MON, .TUE, .WED, .THU, .FRI, .SAT, .SUN]
        return Alarm(alarmId: nil, enable: enable, name: name, hour: hour, minute: minute, dayOfWeeks: dayOfWeeks)
    }
    
    func fetchAlarms() {
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = KeychainHandler.getAnonymousAuthToken() else {
            self.alertMessage = R.string.localizable.errorFailedToGetTheAuthenticationInformation()
            self.showingAlert = true
            return
        }
        AlarmStore.fetchAnonymousAlarms(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword) { result in
            switch result {
            case let .success(alarms):
                self.alarms = alarms
            case .failure:
                self.alertMessage = R.string.localizable.alarmFailedToGetTheAlarmList()
                self.showingAlert = true
            }
        }
    }
    
    func updateAlarmEnable(alarmId: Int, isEnable: Bool) {
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = KeychainHandler.getAnonymousAuthToken() else {
            self.alertMessage = R.string.localizable.errorFailedToGetTheAuthenticationInformation()
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
                break
            case .failure:
                self.alertMessage = R.string.localizable.alarmFailedToEditTheAlarm()
                self.showingAlert = true
            }
        }
    }
    
    func editAlarm(alarm: Alarm) {
        selectedAlarm = alarm
        showingEditAlarmSheet = true
    }
}
