import Foundation
import SwiftUI
import Combine

class AlarmDetailViewState: ObservableObject {
    @Published var alarm: Alarm
    @Published var characters: [Chara] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var sheet: AlarmDetailViewSheetItem?
    @Published var selectedChara: Chara?
    @Published var selectedCharaCall: CharaCall?
    @Published var showingIndicator: Bool = false
    @Published var dismiss: Bool = false
    
    var dismissRequest: AnyPublisher<Void, Never> {
        dismissSubject.eraseToAnyPublisher()
    }
    private let dismissSubject = PassthroughSubject<Void, Never>()
    
    
    let type: AlarmDetailViewTyep
    private let alarmRepository: AlarmRepository = AlarmRepository()
    private let charaCallRepository: CharaCallRepository = CharaCallRepository()
    private let charaRepository: CharaRepository = CharaRepository()
    
    
    var timeDefferenceString: String {
        if alarm.timeDifference >= 0 {
            return "GMT+\(abs(alarm.timeDifference))"
        } else {
            return "GMT-\(abs(alarm.timeDifference))"
        }
    }
    
    var alarmTimeString: String {
        return "\(String(format: "%02d", alarm.hour)):\(String(format: "%02d", alarm.minute))(GMT+\("9"))"
    }
    
//    var enableDaysString: String {
//        return alarm.dayOfWeeks.map { $0.rawValue + ", "}.description
//    }
//    
    init(alarm: Alarm, type: AlarmDetailViewTyep) {
        self.alarm = alarm
        self.type = type
    }
    
    func onAppear() {
        Task { @MainActor in
            do {
                // キャラクター一覧取得
                let characters = try await charaRepository.fetchCharacters()
                self.characters = characters
                
                // 現在のキャラを取得
                if alarm.charaID.isNotEmpty {
                    let chara = try await charaRepository.fetchCharacter(charaID: alarm.charaID)
                    self.selectedChara = chara
                }
                
                // CharaCallを取得
//                if let charaCallId = alarm.charaCallId {
//                    let charaCall = try await charaCallRepository.findByCharaCallId(charaCallId: charaCallId)
//                    self.selectedCharaCall = charaCall
//                }
            } catch {
                // TODO: キャラクター情報の取得に失敗しました的なアラートを表示
                print("----")
                print(error)
                print("----")
            }
        }
    }
    
    func createAlarm() {
        guard let userID = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
              let authToken = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
            self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
            self.showingAlert = true
            return
        }
        Task { @MainActor in
            showingIndicator = true
            do {
                let alarmRequest = self.alarm.toAlarmRequest(userID: UUID(uuidString: userID)!)
                let alarmAddRequest = AlarmAddRequest(alarm: alarmRequest)
                try await alarmRepository.addAlarm(userID: userID, authToken: authToken, requestBody: alarmAddRequest)
                dismissSubject.send()
                showingIndicator = false
            } catch {
                self.alertMessage = "xxxx"
                self.showingAlert = true
            }
        }
    }
    
    func editAlarm() {
        // TODO: ここでアラーム更新
    }
    
    func deleteAlarm() {
        guard let userID = charalarmEnvironment.keychainHandler.getAnonymousUserName(),
              let authToken = charalarmEnvironment.keychainHandler.getAnonymousAuthToken() else {
            self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
            self.showingAlert = true
            return
        }
        Task { @MainActor in
            showingIndicator = true
            do {
                let alarmDeleteRequest = AlarmDeleteRequest(alarmID: alarm.alarmID)
                try await alarmRepository.deleteAlarm(userID: userID, authToken: authToken, requestBody: alarmDeleteRequest)
                dismissSubject.send()
                showingIndicator = false
            } catch {
                self.alertMessage = "xyz"
                self.showingAlert = true
            }
        }
    }

    func setRandomChara() {
        // alarm.charaID = nil
        alarm.charaCallId = nil
        selectedChara = nil
        selectedCharaCall = nil
    }
    
    func setCharaAndCharaCall(chara: Chara, charaCall: CharaCall?) {
        alarm.charaID = chara.charaID
        selectedChara = chara
        // alarm.charaCallId = charaCall?.charaCallId ?? nil
        selectedCharaCall = charaCall
    }
        
    func showVoiceList(chara: Chara) {
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
    
//    func updateDayOfWeek(dayOfWeeks: [DayOfWeek]) {
//        alarm.dayOfWeeks = dayOfWeeks
//    }
//    
//    func updateDayOfWeek(isEnable: Bool, dayOfWeek: DayOfWeek) {
//        if let index = alarm.dayOfWeeks.firstIndex(of: dayOfWeek) {
//            alarm.dayOfWeeks.remove(at: index)
//        }
//        if isEnable {
//            alarm.dayOfWeeks.append(dayOfWeek)
//        }
//    }
    
    func timeDirrerenceTapped() {
        sheet = .timeDeffarenceList
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
