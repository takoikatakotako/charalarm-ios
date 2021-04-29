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
    let alarmRepository: AlarmRepository = AlarmRepository()
    let charaCallRepository: CharaCallRepository = CharaCallRepository()
    let charaRepository: CharaRepository = CharaRepository()

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
        charaRepository.fetchCharacters { [weak self] result in
            switch result {
            case let .success(characters):
                self?.characters = characters
            case .failure(_):
                break
            }
        }
        
        if let charaId = alarm.charaId {
            charaRepository.fetchCharacter(charaId: charaId) { [weak self] result in
                switch result {
                case let .success(character):
                    self?.selectedChara = character
                case let .failure(error):
                    print(error)
                    break
                }
            }
        }
        
        if let charaCallId = alarm.charaCallId {
            charaCallRepository.findByCharaCallId(charaCallId: charaCallId) { [weak self] result in
                switch result {
                case let .success(charaCall):
                    self?.selectedCharaCall = charaCall
                case let .failure(error):
                    print(error)
                    break
                }
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
    
    func setCharaAndCharaCall(chara: Character, charaCall: CharaCallResponseEntity?) {
        alarm.charaId = chara.charaId
        selectedChara = chara
        
        alarm.charaCallId = charaCall?.charaCallId ?? nil
        selectedCharaCall = charaCall
    }
    
    func deleteAlarm(alarmId: Int, completion: @escaping () -> Void) {
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
            self.showingAlert = true
            self.alertMessage = R.string.localizable.errorFailedToGetAuthenticationInformation()
            return
        }
        alarmRepository.deleteAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarmId: alarmId) { [weak self] result in
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
        
        alarmRepository.addAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { result in
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
        
        alarmRepository.editAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { result in
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
