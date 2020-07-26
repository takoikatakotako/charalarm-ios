import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    
    func fetchCharacters() {
        let url = URL(string: "https://charalarm.com/api/characters.json")!
        
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
                
                guard let characters = try? JSONDecoder().decode([Character].self, from: data) else {
                    print("パース失敗")
                    return
                }
                
                DispatchQueue.main.async {
                    self.characters = characters
                    
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
