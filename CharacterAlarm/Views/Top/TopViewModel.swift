import SwiftUI
import AVFoundation
import AdSupport
import AppTrackingTransparency

enum TopViewModelAlart: Identifiable {
    case failedToGetCharacterInformation(String)
    var id: String {
        switch self {
        case let .failedToGetCharacterInformation(message):
            return message
        }
    }
}

class TopViewModel: ObservableObject {
    @Published var charaImage = UIImage()
    @Published var showNews: Bool = false
    @Published var showCharaList: Bool = false
    @Published var showAlarmList: Bool = false
    @Published var showConfig: Bool = false
    @Published var showingAlert: Bool = false
    @Published var alertMessage: String = ""
    var audioPlayer: AVAudioPlayer?

    func onAppear() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .authorized:
            print("Allow Tracking")
            print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
        case .denied:
            print("😭拒否")
        case .restricted:
            print("🥺制限")
        case .notDetermined:
            print("SSSSS")
        @unknown default:
            print("xxxx")
        }
    }
    
    func tapped() {
        guard let charaDomain = UserDefaultsHandler.getCharaDomain() else {
            DispatchQueue.main.async {
                self.alertMessage = "選択中のキャラクターの情報をを取得できませんでした"
                self.showingAlert = true
            }
            return
        }
        
        guard let resource = getResource(charaDomain: charaDomain) else {
            DispatchQueue.main.async {
                self.alertMessage = "リソースを取得できませんでした"
                self.showingAlert = true
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
                self.alertMessage = R.string.localizable.errorFailedToGetCharacterInformation()
                self.showingAlert = true
            }
        }
    }
    
    func setChara() {
        guard let charaDomain = UserDefaultsHandler.getCharaDomain() else {
            DispatchQueue.main.async {
                self.alertMessage = R.string.localizable.errorFailedToGetCharacterInformation()
                self.showingAlert = true
            }
            return
        }
        
        guard let resource = getResource(charaDomain: charaDomain) else {
            DispatchQueue.main.async {
                self.alertMessage = R.string.localizable.errorFailedToGetCharactersResources()
                self.showingAlert = true
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
                self.alertMessage = "キャラクターの画像をセットできませんでした"
                self.showingAlert = true
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
