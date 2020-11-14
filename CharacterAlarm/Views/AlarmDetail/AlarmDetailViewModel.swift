import Foundation
import SwiftUI

class AlarmDetailViewModel: ObservableObject {
    @Published var alarm: Alarm
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
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
    
    func updateAlarmName(name: String) {
        alarm.name = name
    }
    
    func updateAlarmTime(hour: Int, minute: Int) {
        alarm.hour = hour
        alarm.minute = minute
    }

    func updateDayOfWeek(dayOfWeeks: [DayOfWeek]) {
        alarm.dayOfWeeks = dayOfWeeks
    }
}
