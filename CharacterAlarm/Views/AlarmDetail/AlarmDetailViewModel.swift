import Foundation
import SwiftUI

class AlarmDetailViewModel: ObservableObject {
    @Published var alarm: Alarm
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    var alarmTimeString: String {
        return "\(alarm.hour):\(alarm.minute)(GMT+\("9"))"
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
        let url = URL(string: BASE_URL + "/api/anonymous/alarm/add")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
        request.allHTTPHeaderFields = header
        
        guard let anonymousUserName = UserDefaults.standard.string(forKey: ANONYMOUS_USER_NAME),
            let anonymousUserPassword = UserDefaults.standard.string(forKey: ANONYMOUS_USER_PASSWORD) else {
                self.showingAlert = true
                self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                return
        }
        
        let anonymousAlarmBean = AnonymousAlarmBean(
            anonymousUserName: anonymousUserName,
            password: anonymousUserPassword,
            enable: self.alarm.enable,
            name: self.alarm.name,
            hour: self.alarm.hour,
            minute: self.alarm.minute,
            dayOfWeeks: self.alarm.dayOfWeeks)
        guard let httpBody = try? JSONEncoder().encode(anonymousAlarmBean) else {
            self.showingAlert = true
            self.alertMessage = "不明なエラーです（パース失敗）"
            return
        }
        request.httpBody = httpBody
        
        print("****")
        print(request.curlString)
        print("****")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
            if let error = error {
                print("クライアントサイドエラー: \(error.localizedDescription)")
                self.showingAlert = true
                self.alertMessage = "不明なエラーが発生しました。（クライアント）"
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                self.showingAlert = true
                self.alertMessage = "不明なエラーが発生しました。（クライアント）"
                return
            }
            
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = "アラームを保存しました。"
                    return
                }
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
                print(#file)
                print(#function)
                print(#line)
                print(data)
                
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = "不明なエラーが発生しました。（パース失敗）"
                }
            }
        }
        task.resume()
    }
    
    private func editAlarm(alarmId: Int) {
        guard let anonymousUserName = UserDefaults.standard.string(forKey: ANONYMOUS_USER_NAME),
            let anonymousUserPassword = UserDefaults.standard.string(forKey: ANONYMOUS_USER_PASSWORD) else {
                self.showingAlert = true
                self.alertMessage = "不明なエラーです（UserDefaultsに匿名ユーザー名とかがない）"
                return
        }

        AlarmStore.editAlarm(anonymousUserName: anonymousUserName, anonymousUserPassword: anonymousUserPassword, alarm: alarm) { error in
            if let error = error {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = error.localizedDescription
                }
                return
            }
            DispatchQueue.main.async {
                self.showingAlert = true
                self.alertMessage = "編集完了しました"
            }
        }
    }
    
    func updateAlarmName(name: String) {
        alarm.name = name
    }
    //
    //    func updateAlarmTime(hour: Int, minute: Int) {
    //        alarm.hour = hour
    //        alarm.minute = minute
    //    }
    //
    //    func updateTimeDifference(timeDifference: Int) {
    //        alarm.timeDifference = timeDifference
    //    }
    //
    func updateDayOfWeek(dayOfWeeks: [DayOfWeek2]) {
        alarm.dayOfWeeks = dayOfWeeks
    }
}
