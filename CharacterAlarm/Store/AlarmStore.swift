import UIKit

class AlarmStore {
    
    static func fetchAnonymousAlarms(anonymousUserName: String, anonymousUserPassword: String, completion: @escaping (Error?, [Alarm]) -> Void) {
        let url = URL(string: BASE_URL + "/api/anonymous/alarm/list")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
        request.allHTTPHeaderFields = header
        
        let anonymousAuthBean = AnonymousAuthBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword)
        guard let httpBody = try? JSONEncoder().encode(anonymousAuthBean) else {
            completion(CharalarmError.clientError, [])
            return
        }
        request.httpBody = httpBody
        
        print("****")
        print(request.curlString)
        print("****")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("クライアントサイドエラー: \(error.localizedDescription)")
                completion(CharalarmError.clientError, [])
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(CharalarmError.serverError, [])
                return
            }
            
            if response.statusCode == 200 {
                guard let jsonResponse = try? JSONDecoder().decode(JsonResponseBean<[Alarm]>.self, from: data) else {
                    completion(CharalarmError.decode, [])
                    return
                }
                completion(nil, jsonResponse.data)
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                let message = """
                サーバサイドエラー
                ステータスコード: \(response.statusCode)
                File: \(#file)
                Function: \(#function)
                Line: \(#line)
                """
                print(message)
                completion(CharalarmError.serverError, [])
            }
        }
        task.resume()
    }
    
    
    static func deleteAlarm(anonymousUserName: String, anonymousUserPassword: String, alarmId: Int, completion: @escaping (Error?) -> Void) {
        let url = URL(string: BASE_URL + "/api/anonymous/alarm/delete/\(alarmId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
        request.allHTTPHeaderFields = header
        
        let anonymousAuthBean = AnonymousAuthBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword)
        guard let httpBody = try? JSONEncoder().encode(anonymousAuthBean) else {
            completion(CharalarmError.clientError)
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
                completion(CharalarmError.clientError)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(CharalarmError.serverError)
                return
            }
            
            if response.statusCode == 200 {
                guard let jsonResponse = try? JSONDecoder().decode(JsonResponseBean<String>.self, from: data) else {
                    completion(CharalarmError.decode)
                    return
                }
                print(jsonResponse.data)
                completion(nil)
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
                print(#file)
                print(#function)
                print(#line)
                completion(CharalarmError.serverError)
            }
        }
        task.resume()
    }
    
    
    
    static func editAlarm(anonymousUserName: String, anonymousUserPassword: String, alarm: Alarm, completion: @escaping (Error?) -> Void) {
        guard let alarmId = alarm.alarmId else {
            return
        }
        let url = URL(string: BASE_URL + "/api/anonymous/alarm/edit/\(alarmId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let header: [String: String] = ["X-API-VERSION": "0", "Content-Type": "application/json"]
        request.allHTTPHeaderFields = header
        
        let anonymousAlarmBean = AnonymousAlarmBean(
            anonymousUserName: anonymousUserName,
            password: anonymousUserPassword,
            enable: alarm.enable,
            name: alarm.name,
            hour: alarm.hour,
            minute: alarm.minute,
            dayOfWeeks: alarm.dayOfWeeks)
        guard let httpBody = try? JSONEncoder().encode(anonymousAlarmBean) else {
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
                completion(CharalarmError.clientError)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(CharalarmError.serverError)
                return
            }
            
            if response.statusCode == 200 {
                guard let jsonResponse = try? JSONDecoder().decode(JsonResponseBean<String>.self, from: data) else {
                    completion(CharalarmError.decode)
                    return
                }
                print(jsonResponse.data)
                completion(nil)
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
                print(#file)
                print(#function)
                print(#line)
                completion(CharalarmError.serverError)
            }
        }
        task.resume()
    }
    
    
    
    //    static func save(alarm: Alarm, error: @escaping (NSError?) -> Void) {
    //        let db = Firestore.firestore()
    //        let ref = db.collection(Alarm.collectionName).document(alarm.id)
    //        ref.setData(alarm.data) { (err) in
    //            if err == nil {
    //                error(nil)
    //            } else {
    //                error(err as NSError?)
    //            }
    //        }
    //    }
    //
    //    static func featchAlarms(uid: String, completion: @escaping ([Alarm], NSError?) -> Void) {
    //        let db = Firestore.firestore()
    ////        let ref = db.collection(Alarm.collectionName).whereField(Alarm.uid, isEqualTo: uid)
    //        let ref = db.collection(Alarm.collectionName)
    //        ref.getDocuments { querySnapshot, error in
    //            var alarms: [Alarm] = []
    //            if let error = error {
    //                completion(alarms, error as NSError)
    //            } else {
    //                for document in querySnapshot!.documents {
    //                    let alarm = Alarm(id: document.documentID, document: document)
    //                    alarms.append(alarm)
    //                }
    //                completion(alarms, nil)
    //            }
    //        }
    //    }
    //
    //    static func deleteAlarm(alarmId: Int, completion: @escaping (NSError?) -> Void) {
    ////        let db = Firestore.firestore()
    ////        let ref = db.collection(Alarm.collectionName).document(alarmId)
    ////        ref.delete { (error) in
    ////            completion(error as NSError?)
    ////        }
    //    }
}
