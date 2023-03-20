import Foundation
import SwiftUI

protocol AlarmDetailViewModelProtocol: ObservableObject {
    
}

class AlarmDetailViewState: AlarmDetailViewModelProtocol {
    @Published var alarm: Alarm
    @Published var characters: [Character] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var sheet: AlarmDetailViewSheetItem?
    @Published var selectedChara: Character?
    @Published var selectedCharaCall: CharaCallResponseEntity?
    @Published var showingIndicator: Bool = false
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
        Task { @MainActor in
            do {
                // キャラクター一覧取得
                let characters = try await charaRepository.fetchCharacters()
                self.characters = characters
                
                // 現在のキャラを取得
                if let charaId = alarm.charaId {
                    let chara = try await charaRepository.fetchCharacter(charaId: charaId)
                    self.selectedChara = chara
                }
                
                // CharaCallを取得
                if let charaCallId = alarm.charaCallId {
                    let charaCall = try await charaCallRepository.findByCharaCallId(charaCallId: charaCallId)
                    self.selectedCharaCall = charaCall
                }
            } catch {
                // TODO: キャラクター情報の取得に失敗しました的なアラートを表示
            }
        }
    }
    
    func createOrUpdateAlarm(completion: @escaping () -> Void) {
        showingIndicator = true
        if let alarmId = alarm.alarmId {
            editAlarm(alarmId: alarmId, completion: completion)
        } else {
            createAlarm(completion: completion)
        }
    }
    
    func setRandomChara() {
        alarm.charaId = nil
        alarm.charaCallId = nil
        selectedChara = nil
        selectedCharaCall = nil
    }
    
    func setCharaAndCharaCall(chara: Character, charaCall: CharaCallResponseEntity?) {
        alarm.charaId = chara.charaId
        selectedChara = chara
        
        alarm.charaCallId = charaCall?.charaCallId ?? nil
        selectedCharaCall = charaCall
    }
    
    func deleteAlarm(alarmId: Int, completion: @escaping () -> Void) {
//        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
//              let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
//            self.showingAlert = true
//            self.alertMessage = R.string.localizable.errorFailedToGetAuthenticationInformation()
//            return
//        }
//        alarmRepository.deleteAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarmId: alarmId) { [weak self] result in
//            switch result {
//            case .success:
//                completion()
//            case .failure:
//                self?.alertMessage = "削除に失敗しました"
//                self?.showingAlert = true
//            }
//        }
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
        
//        alarmRepository.addAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { result in
//            switch result {
//            case .success:
//                completion()
//            case .failure:
//                self.alertMessage = R.string.localizable.alarmFailedToCreateAnAlarm()
//                self.showingAlert = true
//            }
//        }
    }
    
    private func editAlarm(alarmId: Int, completion: @escaping () -> Void) {
        guard let anonymousUserName = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
            let anonymousUserPassword = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
            self.alertMessage = R.string.localizable.errorFailedToGetAuthenticationInformation()
                self.showingAlert = true
                return
        }
        
//        alarmRepository.editAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { result in
//            switch result {
//            case .success(_):
//                completion()
//            case .failure:
//                self.alertMessage = R.string.localizable.alarmFailedToEditTheAlarm()
//                self.showingAlert = true
//            }
//        }
    }
}
