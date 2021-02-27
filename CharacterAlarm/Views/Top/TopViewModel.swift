import SwiftUI
import AVFoundation
import AdSupport
import AppTrackingTransparency

enum TopViewModelAlert: Identifiable {
    case failedToGetCharacterInformation
    case failedToGetCharacterSelectionInformation
    case failedToGetCharactersResources
    case failedToSetCharacterImage
    case thisFeatureIsNotAvailableInYourRegion
    var id: Int {
        return hashValue
    }
}

enum TopViewModelSheet: Identifiable {
    case newsList
    case characterList
    case alarmList
    case config
    var id: Int {
        return hashValue
    }
}

class TopViewModel: ObservableObject {
    @Published var charaImage = UIImage()
    @Published var alert: TopViewModelAlert?
    @Published var sheet: TopViewModelSheet?
    
    var audioPlayer: AVAudioPlayer?

    func onAppear() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func newsButtonTapped() {
        sheet = .newsList
    }
    
    func characterListButtonTapped() {
        sheet = .characterList
    }
    
    func alarmButtonTapped() {
        guard Locale.current.regionCode != "CN" else {
            alert = .thisFeatureIsNotAvailableInYourRegion
            return
        }
        sheet = .alarmList
    }
    
    func configButtonTapped() {
        sheet = .config
    }
    
    func tapped() {
        guard let charaDomain = UserDefaultsHandler.getCharaDomain() else {
            DispatchQueue.main.async {
                self.alert = .failedToGetCharacterSelectionInformation
            }
            return
        }
        
        guard let resource = getResource(charaDomain: charaDomain) else {
            DispatchQueue.main.async {
                self.alert = .failedToGetCharactersResources
            }
            return
        }
        
        guard let key = resource.expression.keys.randomElement() else {
            return
        }

        setCharaImage(charaDomain: charaDomain, resource: resource, key: key)
        playCharaVoice(charaDomain: charaDomain, resource: resource, key: key)
    }
    
    func featchCharacter(charaDomain: String, completion: @escaping (Character) -> Void) {
        CharacterStore.fetchCharacter(charaDomain: charaDomain) { result in
            switch result {
            case let .success(character):
                completion(character)
            case .failure:
                self.alert = .failedToGetCharacterInformation
            }
        }
    }
    
    func setChara() {
        guard let charaDomain = UserDefaultsHandler.getCharaDomain() else {
            DispatchQueue.main.async {
                self.alert = .failedToGetCharacterSelectionInformation
            }
            return
        }
        
        guard let resource = getResource(charaDomain: charaDomain) else {
            DispatchQueue.main.async {
                self.alert = .failedToGetCharactersResources
            }
            return
        }
        
        guard let key = resource.expression.keys.randomElement() else {
            return
        }
        
        setCharaImage(charaDomain: charaDomain, resource: resource, key: key)
    }
        
    private func getResource(charaDomain: String) -> Resource? {
        guard let data = try? FileHandler.loadData(directoryName: charaDomain, fileName: "resource.json") else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let resource = try? decoder.decode(Resource.self, from: data) else {
            return nil
        }
        return resource
    }
    
    private func setCharaImage(charaDomain: String, resource: Resource, key: String) {
        guard let imageName = resource.expression[key]?.images.randomElement() else {
            return
        }
        
        do {
            let data = try FileHandler.loadData(directoryName: charaDomain, fileName: imageName)
            charaImage = UIImage(data: data)!
        } catch {
            DispatchQueue.main.async {
                self.alert = .failedToSetCharacterImage
            }
        }
    }
    
    private func playCharaVoice(charaDomain: String, resource: Resource, key: String) {
        guard let voiceName = resource.expression[key]?.voices.randomElement() else {
            return
        }
        
        do {
            let data = try FileHandler.loadData(directoryName: charaDomain, fileName: voiceName)
            audioPlayer = try? AVAudioPlayer(data: data)
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }
}
