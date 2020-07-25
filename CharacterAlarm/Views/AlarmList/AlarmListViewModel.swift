import Foundation

class AlarmListViewModel: ObservableObject {
    @Published var alarms: [Alarm2] = []
    
    func fetchAlarms() {
        let url = URL(string: "https://api.charalarm.com/api/anonymous/alarm/list")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
//        let anonymousAuthBean = AnonymousAuthBean(anonymousUserName: "xxx", password: "xxx")
//        let data = anonymousAuthBean.encode(anonymousAuthBean)
//        request.httpBody = data

        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
            if let error = error {
                print("クライアントサイドエラー: \(error.localizedDescription) \n")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                return
            }
            
            if response.statusCode == 200 {
                print(data)
                
                guard let alarms = try? JSONDecoder().decode([Alarm2].self, from: data) else {
                    print("パース失敗")
                    return
                }
                
                DispatchQueue.main.async {
                    self.alarms = alarms
                }
                // ...これ以降decode処理などを行い、UIのUpdateをメインスレッドで行う
                
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
                print(#file)
                print(#function)
                print(#line)
            }
            
        }
        task.resume()
    }
    
}
