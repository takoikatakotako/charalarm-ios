import Foundation

class AlarmListViewState: ObservableObject {
    @Published var alarms: [Alarm] = []
    @Published var sheet: AlarmListViewSheetItem?
    @Published var alert: AlarmListViewAlertItem?
    @Published var showingIndicator: Bool = true
    
    let alarmRepository: AlarmRepository = AlarmRepository()
    
    func addAlarmButtonTapped() {
        if alarms.count < 3 {
            sheet = .alarmDetailForCreate
        } else {
            alert = .error(UUID(), R.string.localizable.alarmYouCanCreateUpToThreeAlarms())
        }
    }
    
    func createNewAlarm() -> Alarm {
        let alarmID = UUID()
        let date = Date()
        let name = R.string.localizable.alarmNewAlarm()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let enable = true
        let dayOfWeeks: [DayOfWeek] = [.MON, .TUE, .WED, .THU, .FRI, .SAT, .SUN]
        return Alarm(alarmID: alarmID, type: .VOIP_NOTIFICATION, enable: enable, name: name, hour: hour, minute: minute, dayOfWeeks: dayOfWeeks)
    }
    
    func fetchAlarms() {
        Task { @MainActor in
            showingIndicator = true
            guard let userID = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
                  let authToken = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
                    alert = .error(UUID(), R.string.localizable.errorFailedToGetAuthenticationInformation())
                return
            }
            
            do {
//                let alarms = try await alarmRepository.fetchAlarms(userID: userID, authToken: authToken)
//                self.showingIndicator = false
//                self.alarms = alarms
            } catch {
                self.alert = .error(UUID(), R.string.localizable.alarmFailedToGetTheAlarmList())
            }
        }
    }
    
    func updateAlarmEnable(alarmId: UUID, isEnable: Bool) {
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
            alert = .error(UUID(), R.string.localizable.errorFailedToGetAuthenticationInformation())
            return
        }
        
//        guard let index = alarms.firstIndex(where: { $0.alarmID == alarmId }) else {
//            return
//        }
//
//        alarms[index].enable = isEnable
//        let alarm = alarms[index]
//        alarmRepository.editAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { result in
//            switch result {
//            case .success(_):
//                break
//            case .failure:
//                self.alert = .error(UUID(), R.string.localizable.alarmFailedToEditTheAlarm())
//            }
//        }
    }
//    
//    func createAlarm() {
//        sheet = .alarmDetailForCreate
//    }
//    
    func editAlarm(alarm: Alarm) {
        sheet = .alarmDetailForEdit(alarm)
    }
}
