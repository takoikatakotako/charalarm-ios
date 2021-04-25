import Foundation
import SwiftUI

protocol AlarmDetailViewModelProtocol: ObservableObject {
    
}

enum AlarmDetailViewSheet: Identifiable {
    case voiceList(Character)
    var id: Int {
        switch self {
        case let .voiceList(character):
            return character.charaId
        }
    }
}

class AlarmDetailViewModel: AlarmDetailViewModelProtocol {
    @Published var alarm: Alarm
    @Published var characters: [Character] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var sheet: AlarmDetailViewSheet?
    @Published var selectedChara: Character?
    @Published var selectedCharaCall: CharaCallResponseEntity?
    
    var alarmTimeString: String {
        return "\(String(format: "%02d", alarm.hour)):\(String(format: "%02d", alarm.minute))(GMT+\("9"))"
    }
    
    var enableDaysString: String {
        return alarm.dayOfWeeks.map { $0.rawValue + ", "}.description
    }
    
    init(alarm: Alarm) {
        self.alarm = alarm
    }
    
    func onAppear() {
        CharacterStore.fetchCharacters { [weak self] result in
            switch result {
            case let .success(characters):
                self?.characters = characters
            case .failure(_):
                break
            }
        }
    }
    
    func createOrUpdateAlarm(completion: @escaping () -> Void) {
        if let alarmId = alarm.alarmId {
            editAlarm(alarmId: alarmId, completion: completion)
        } else {
            createAlarm(completion: completion)
        }
    }
    
    func setChara(chara: Character) {
        alarm.charaId = chara.charaId
        selectedChara = chara
    }
    
    func setCharaCall(charaCall: CharaCallResponseEntity) {
        alarm.charaCallId = charaCall.charaCallId
        selectedCharaCall = charaCall
    }
    
    func deleteAlarm(alarmId: Int, completion: @escaping () -> Void) {
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
            self.showingAlert = true
            self.alertMessage = R.string.localizable.errorFailedToGetAuthenticationInformation()
            return
        }
        AlarmStore.deleteAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarmId: alarmId) { [weak self] result in
            switch result {
            case .success:
                completion()
            case .failure:
                self?.alertMessage = "削除に失敗しました"
                self?.showingAlert = true
            }
        }
    }
    
    func showVoiceList(chara: Character) {
        sheet = .voiceList(chara)
    }
    
    func updateAlarmName(name: String) {
        alarm.name = name
    }
    
    func updateAlarmHour(hour: Int) {
        alarm.hour = hour
    }
    
    func updateAlarmMinute(minute: Int) {
        alarm.minute = minute
    }

    func updateDayOfWeek(dayOfWeeks: [DayOfWeek]) {
        alarm.dayOfWeeks = dayOfWeeks
    }
    
    func updateDayOfWeek(isEnable: Bool, dayOfWeek: DayOfWeek) {
        if let index = alarm.dayOfWeeks.firstIndex(of: dayOfWeek) {
            alarm.dayOfWeeks.remove(at: index)
        }
        if isEnable {
            alarm.dayOfWeeks.append(dayOfWeek)
        }
    }
    
    private func createAlarm(completion: @escaping () -> Void) {
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
            let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
            self.alertMessage = R.string.localizable.errorFailedToGetAuthenticationInformation()
                self.showingAlert = true
                return
        }
        
        AlarmStore.addAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { result in
            switch result {
            case .success:
                completion()
            case .failure:
                self.alertMessage = R.string.localizable.alarmFailedToCreateAnAlarm()
                self.showingAlert = true
            }
        }
    }
    
    private func editAlarm(alarmId: Int, completion: @escaping () -> Void) {
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
            let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
            self.alertMessage = R.string.localizable.errorFailedToGetAuthenticationInformation()
                self.showingAlert = true
                return
        }
        
        AlarmStore.editAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { result in
            switch result {
            case .success(_):
                completion()
            case .failure:
                self.alertMessage = R.string.localizable.alarmFailedToEditTheAlarm()
                self.showingAlert = true
            }
        }
    }
}
