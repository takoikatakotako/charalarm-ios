import Foundation

class AlarmListViewState: ObservableObject {
    @Published var alarms: [Alarm] = []
    @Published var sheet: AlarmListViewSheetItem?
    @Published var alert: AlarmListViewAlertItem?
    @Published var showingIndicator: Bool = true
    
    private let alarmRepository: AlarmRepository = AlarmRepository()
    private let keychainRepository: KeychainRepository = KeychainRepository()
    
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
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let timeDifference = Decimal(TimeZone.current.secondsFromGMT(for: date) / 60 / 60)
        let enable = true
        
        return Alarm(
            alarmID: alarmID,
            type: .IOS_VOIP_PUSH_NOTIFICATION,
            enable: enable,
            name: name,
            hour: hour,
            minute: minute,
            timeDifference: timeDifference,
            charaName: "",
            charaID: "",
            voiceFileName: "",
            sunday: true,
            monday: true,
            tuesday: true,
            wednesday: true,
            thursday: true,
            friday: true,
            saturday: true
        )
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
                let alarms = try await alarmRepository.fetchAlarms(userID: userID, authToken: authToken)
                self.showingIndicator = false
                self.alarms = alarms.map { $0.toAlarm() }
            } catch {
                self.alert = .error(UUID(), R.string.localizable.alarmFailedToGetTheAlarmList())
            }
        }
    }
    
    func updateAlarmEnable(alarmId: UUID, isEnable: Bool) {
        guard let userID = keychainRepository.getUserID(),
              let authToken = keychainRepository.getAuthToken() else {
            alert = .error(UUID(), R.string.localizable.errorFailedToGetAuthenticationInformation())
            return
        }
        
        guard let index = alarms.firstIndex(where: { $0.alarmID == alarmId }) else {
            return
        }

        alarms[index].enable = isEnable
        let alarm = alarms[index]
        Task { @MainActor in
            do {
                let requestBody = AlarmEditRequest(alarm: alarm.toAlarmRequest(userID: UUID(uuidString: userID)!))
                try await alarmRepository.editAlarm(userID:userID, authToken: authToken, requestBody: requestBody)
            } catch {
                alert = .error(UUID(), R.string.localizable.alarmFailedToEditTheAlarm())
            }
        }
    }
    
    func editAlarm(alarm: Alarm) {
        sheet = .alarmDetailForEdit(alarm)
    }
}
