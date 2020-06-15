import UIKit

class ConfigViewModel: ObservableObject {
    @Published var character: Character2?

    var versionString: String {
        return getVersion()
    }

    func openUrlString(string: String) {
        guard let url = URL(string: string) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func fetchCharacter(characterId: String) {
          let url = URL(string: "https://charalarm.com/api/\(characterId)/character.json")!
          
          let task = URLSession.shared.dataTask(with: url) { data, response, error in
              
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
                  
                  guard let character = try? JSONDecoder().decode(Character2.self, from: data) else {
                      print("パース失敗")
                      return
                  }
                  
                  DispatchQueue.main.async {
                      self.character = character
                      
                  }
                  // ...これ以降decode処理などを行い、UIのUpdateをメインスレッドで行う
                  
              } else {
                  // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                  print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
              }
              
          }
          task.resume()
      }
    
    private func getVersion() -> String {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
            let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
                return ""
        }
        return "\(version)(\(build))"
    }
}
