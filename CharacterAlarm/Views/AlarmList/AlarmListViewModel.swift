import Foundation

enum AlarmListViewModelSheet: Identifiable {
    case alarmDetail(Alarm)
    var id: String {
        switch self {
        case let .alarmDetail(alarm):
            return alarm.id
        }
    }
}

enum AlarmListViewModelAlert: Identifiable {
    case ad(UUID)
    case error(UUID, String)
    var id: UUID {
        switch self {
        case let .ad(id):
            return id
        case let .error(id, _):
            return id
        }
    }
}

class AlarmListViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    @Published var sheet: AlarmListViewModelSheet?
    @Published var alert: AlarmListViewModelAlert?
    @Published var showingIndicator: Bool = true
    let alarmRepository: AlarmRepository = AlarmRepository()
    
    func addAlarmButtonTapped() {
        if alarms.count < 3 {
            editAlarm(alarm: createNewAlarm())
        } else {
            alert = .error(UUID(), R.string.localizable.alarmYouCanCreateUpToThreeAlarms())
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
        showingIndicator = true
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
                alert = .error(UUID(), R.string.localizable.errorFailedToGetAuthenticationInformation())
            return
        }
        alarmRepository.fetchAnonymousAlarms(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword) { result in
            switch result {
            case let .success(alarms):
                self.showingIndicator = false
                self.alarms = alarms
            case .failure:
                self.alert = .error(UUID(), R.string.localizable.alarmFailedToGetTheAlarmList())
            }
        }
    }
    
    func updateAlarmEnable(alarmId: Int, isEnable: Bool) {
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
            alert = .error(UUID(), R.string.localizable.errorFailedToGetAuthenticationInformation())

            return
        }
        
        guard let index = alarms.firstIndex(where: { $0.alarmId == alarmId }) else {
            return
        }
        
        alarms[index].enable = isEnable
        let alarm = alarms[index]
        alarmRepository.editAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { result in
            switch result {
            case .success(_):
                break
            case .failure:
                self.alert = .error(UUID(), R.string.localizable.alarmFailedToEditTheAlarm())
            }
        }
    }
    
    func editAlarm(alarm: Alarm) {
        sheet = .alarmDetail(alarm)
    }
}
