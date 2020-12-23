import Foundation
import SwiftUI

class AlarmDetailViewModel: ObservableObject {
    @Published var alarm: Alarm
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    @Published var xxxx: Bool = true
    
    var alarmTimeString: String {
        return "\(String(format: "%02d", alarm.hour)):\(String(format: "%02d", alarm.minute))(GMT+\("9"))"
    }
    
    var enableDaysString: String {
        return alarm.dayOfWeeks.map { $0.rawValue + ", "}.description
    }
    
    init(alarm: Alarm) {
        self.alarm = alarm
    }
    
    func createOrUpdateAlarm() {
        if let alarmId = alarm.alarmId {
            editAlarm(alarmId: alarmId)
        } else {
            createAlarm()
        }
    }
    
    func deleteAlarm(alarmId: Int, completion: @escaping () -> Void) {
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
              let anonymousUserPassword = KeychainHandler.getAnonymousUserPassword() else {
            self.showingAlert = true
            self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
            return
        }
        AlarmStore.deleteAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarmId: alarmId) { result in
            switch result {
            case .success:
                completion()
            case .failure:
                self.alertMessage = "削除に失敗しました"
                self.showingAlert = true
            }
        }
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
    
    private func createAlarm() {
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
            let anonymousUserPassword = KeychainHandler.getAnonymousUserPassword() else {
                self.showingAlert = true
                self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                return
        }
        
        AlarmStore.addAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { result in
            switch result {
            case .success(_):
                self.alertMessage = "登録完了しました"
                self.showingAlert = true
            case let .failure(error):
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
    }
    
    private func editAlarm(alarmId: Int) {
        guard let anonymousUserName = KeychainHandler.getAnonymousUserName(),
            let anonymousUserPassword = KeychainHandler.getAnonymousUserPassword() else {
                self.showingAlert = true
                self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                return
        }
        
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
}
