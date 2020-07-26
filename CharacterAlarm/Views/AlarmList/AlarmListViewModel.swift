import Foundation

class AlarmListViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func fetchAlarms() {
        let url = URL(string: BASE_URL + "/api/anonymous/alarm/list")!
        
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
        
        let anonymousAuthBean = AnonymousAuthBean(anonymousUserName: anonymousUserName, password: anonymousUserPassword)
        guard let httpBody = try? JSONEncoder().encode(anonymousAuthBean) else {
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
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = "不明なエラーが発生しました。（クライアント）"
                }
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = "不明なエラーが発生しました。（クライアント）"
                }
                return
            }
            
            if response.statusCode == 200 {
                guard let jsonResponse = try? JSONDecoder().decode(JsonResponseBean<[Alarm]>.self, from: data) else {
                    DispatchQueue.main.async {
                        self.showingAlert = true
                        self.alertMessage = "不明なエラーが発生しました。（パース失敗）"
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.alarms = jsonResponse.data
                }
                
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
                print(#file)
                print(#function)
                print(#line)
                
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = "不明なエラーが発生しました。（パース失敗）"
                }
            }
            
        }
        task.resume()
    }
    
}
