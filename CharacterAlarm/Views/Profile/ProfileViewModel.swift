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
        CharacterStore.fetchCharacter(charaDomain: characterId) { result in
            switch result {
            case let .success(character):
                self.character = character
            case let .failure(error):
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
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
        UserDefaultsHandler.setCharaDomain(charaDomain: charaDomain)
    }
}
