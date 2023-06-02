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
    private let keychainRepository: KeychainRepository = KeychainRepository()
    
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
                    
                    // CharaCallを設定
                    self.selectedCharaCall = chara.calls.first { charaCall in
                        charaCall.voice.contains(alarm.voiceFileName)
                    }
                }
            } catch {
                // TODO: キャラクター情報の取得に失敗しました的なアラートを表示
                print("----")
                print(error)
                print("----")
            }
        }
    }
    
    func createOrEditAlarm() {
        switch type {
        case .create:
            createAlarm()
        case .edit:
            editAlarm()
        }
    }

    func deleteAlarm() {
        guard let userID = keychainRepository.getUserID(),
              let authToken = keychainRepository.getAuthToken() else {
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
        selectedChara = nil
        selectedCharaCall = nil
    }
    
    func setCharaAndCharaCall(chara: Chara, charaCall: CharaCall?) {
        alarm.charaID = chara.charaID
        alarm.charaName = chara.name
        alarm.voiceFileName = charaCall?.voice ?? ""
        selectedChara = chara
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

    func timeDirrerenceTapped() {
        sheet = .timeDeffarenceList
    }
    
    private func createAlarm() {
        guard let userID = keychainRepository.getUserID(),
              let authToken = keychainRepository.getAuthToken() else {
            alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
            showingAlert = true
            return
        }
        Task { @MainActor in
            showingIndicator = true
            do {
                let alarmRequest = alarm.toAlarmRequest(userID: UUID(uuidString: userID)!)
                let alarmAddRequest = AlarmAddRequest(alarm: alarmRequest)
                try await alarmRepository.addAlarm(userID: userID, authToken: authToken, requestBody: alarmAddRequest)
                dismissSubject.send()
                showingIndicator = false
            } catch {
                alertMessage = "xxxx"
                showingAlert = true
            }
        }
    }
    
    private func editAlarm() {
        guard let userID = keychainRepository.getUserID(),
              let authToken = keychainRepository.getAuthToken() else {
            alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
            showingAlert = true
            return
        }
        Task { @MainActor in
            showingIndicator = true
            do {
                let alarmRequest = alarm.toAlarmRequest(userID: UUID(uuidString: userID)!)
                let alarmEditRequest = AlarmEditRequest(alarm: alarmRequest)
                try await alarmRepository.editAlarm(userID: userID, authToken: authToken, requestBody: alarmEditRequest)
                dismissSubject.send()
                showingIndicator = false
            } catch {
                alertMessage = "xxxx"
                showingAlert = true
            }
        }
    }
}