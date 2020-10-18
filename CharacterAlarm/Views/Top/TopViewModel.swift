import SwiftUI
import AVFoundation

class TopViewModel: ObservableObject {
    @Published var charaImage = UIImage()
    @Published var showNews: Bool = false
    @Published var showConfig: Bool = false
    @Published var showingAlert: Bool = false
    @Published var alertMessage: String = ""
    var audioPlayer: AVAudioPlayer!
    
    func tapped() {
        guard let charaDomain = UserDefaultsHandler.getCharaDomain() else {
            return
        }
        guard let data = try? FileHandler.loadData(directoryName: charaDomain, fileName: "resource.json") else {
            return
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let resource = try? decoder.decode(Resourse.self, from: data) else {
            return
        }
        
        guard let voices = resource.expression["normal"]?.voice else {
            return
        }
        
        let voice = voices.randomElement()!
        do {
            let data = try FileHandler.loadData(directoryName: charaDomain, fileName: voice)
            audioPlayer = try? AVAudioPlayer(data: data)
            audioPlayer?.play() // → これで音が鳴る
        } catch {
            print(error)
        }
    }
    
    func featchCharacter(charaDomain: String, completion: @escaping (Character) -> Void) {
        CharacterStore.fetchCharacter(charaDomain: charaDomain) { result in
            switch result {
            case let .success(character):
                completion(character)
            case let .failure(error):
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
    }
    
    func setChara() {
        guard let charaDomain = UserDefaultsHandler.getCharaDomain() else {
            return
        }
        guard let data = try? FileHandler.loadData(directoryName: charaDomain, fileName: "resource.json") else {
            return
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let resource = try? decoder.decode(Resourse.self, from: data) else {
            return
        }
        
        guard let images = resource.expression["normal"]?.image else {
            return
        }

        guard let image = images.first else {
            return
        }
        
        do {
            let data = try FileHandler.loadData(directoryName: charaDomain, fileName: image)
            charaImage = UIImage(data: data)!
        } catch {
            
        }
    }
}
