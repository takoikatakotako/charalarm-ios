import Foundation
import CallKit
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var character: Character?
    @Published var showCallView: Bool = false
    @Published var showCallItem = false
    @Published var showCheckItem = false
    @Published var showSelectAlert = false
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func fetchCharacter(characterId: String) {
        CharacterStore.fetchCharacter(charaDomain: characterId) { error, character in
            if let error = error {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = error.localizedDescription
                }
                return
            }
            
            guard let character = character else {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = "所得に失敗しました"
                }
                return
            }
            
            DispatchQueue.main.async {
                self.character = character
            }
        }
    }
    
    func download(characterId: String) {
        let url = URL(string: "https://charalarm.com/audio/\(characterId)/self-introduction.caf")!
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
                    try FileHandler.saveFile(directoryName: characterId, fileName: "self-introduction.caf", data: data)
                } catch {
                    print(error.localizedDescription)
                    print("exception")
                }
                
                
                
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
    
    func selectCharacter() {
        guard let charaDomain = character?.charaDomain else {
            return
        }
        UserDefaultsStore.setCharaDomain(charaDomain: charaDomain)
    }
}
