import SwiftUI
import FirebaseStorage

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character2] = []
    
    func fetchCharacters() {
        let url = URL(string: "https://charalarm.com/api/character-list.json")!
        
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
                
                guard let characters = try? JSONDecoder().decode([Character2].self, from: data) else {
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
            }
            
        }
        task.resume()
    }
    
}
