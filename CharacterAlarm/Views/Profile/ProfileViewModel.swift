import Foundation
import CallKit
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var character: Character2?
    @Published var showCallView: Bool = false
    
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
    
    func download(characterId: String) {
        let url = URL(string: "https://charalarm.com/audio/com.swiswiswift.charalarm.yui/com_swiswiswift_inoue_yui_operation_1.caf")!
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
                
                
                do {
                    try FileHandler.saveFile(directoryName: "characterId", fileName: "sample.caf", data: data)
                } catch {
                    print(error.localizedDescription)
                    print("exception")
                }
                
                
                
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバサイドエラー ステータスコード: \(response.statusCode)\n")
            }
        }
        task.resume()
    }
}
