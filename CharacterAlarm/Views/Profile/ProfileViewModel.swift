import Foundation
import CallKit
import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    let charaDomain: String
    @Published var character: Character?
    @Published var showCallView: Bool = false
    @Published var showCallItem = false
    @Published var showCheckItem = false
    @Published var showSelectAlert = false
    @Published var showingDownloadingModal = false
    @Published var downloadError = false
    @Published var progressMessage = ""
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    private var numberOfResource: Int = 0
    private var numberOfDownloadedReosurce: Int = 0
    
    enum ResourceType: String {
        case image = "image"
        case voice = "voice"
    }
    
    struct ResourceInfo {
        let type: ResourceType
        let name: String
    }
    
    
    var resourceInfos: [ResourceInfo] = []
    
    var charaThumbnailUrlString: String {
        return ResourceHandler.getCharaThumbnailUrlString(charaDomain: charaDomain)
    }
    
    init(charaDomain: String) {
        self.charaDomain = charaDomain
    }
    
    func fetchCharacter() {
        CharacterStore.fetchCharacter(charaDomain: charaDomain) { result in
            switch result {
            case let .success(character):
                self.character = character
            case .failure:
                self.alertMessage = "キャラクター情報の取得に失敗しました。"
                self.showingAlert = true
            }
        }
    }
    
    func download() {
        ResourceStore.downloadSelfIntroduction(charaDomain: charaDomain) { result in
            switch result {
            case .success(_):
                print("自己紹介音声の保存に成功しました")
            case let .failure(error):
                self.alertMessage = "キャラクターのリソースの取得に失敗しました。"
                self.showingAlert = true
            }
        }
    }
    
    func cancel() {
        resourceInfos = []
        downloadError = false
        showingDownloadingModal = false
    }
    
    func close() {
        resourceInfos = []
        downloadError = false
        showingDownloadingModal = false
    }
    
    func selectCharacter() {
        ResourceStore.downloadResourceJson(charaDomain: charaDomain) { result in
            switch result {
            case let .success(resource):
                self.numberOfResource = resource.resource.images.count + resource.resource.voices.count
                self.numberOfDownloadedReosurce = 0
                
                DispatchQueue.main.async {
                    self.progressMessage = "\(String(self.numberOfDownloadedReosurce))/\(String(self.numberOfResource))"
                }
                
                self.resourceInfos = []
                for image in resource.resource.images {
                    self.resourceInfos.append(ResourceInfo(type: .image, name: image))
                }
                
                for voice in resource.resource.voices {
                    self.resourceInfos.append(ResourceInfo(type: .voice, name: voice))
                }
                
                self.downloadResource()
                
            case let .failure(error):
                self.downloadError = true
            }
        }
        
        showingDownloadingModal = true
    }
    
    func downloadResource() {
        guard let resourceInfo = resourceInfos.first else {
            self.numberOfDownloadedReosurce = 0
            self.numberOfResource = 0
            DispatchQueue.main.async {
                self.showingDownloadingModal = false
                self.setCharacter()
            }
            return
        }
        
        ResourceStore.downloadResource(charaDomain: charaDomain, directory: resourceInfo.type.rawValue, fileName: resourceInfo.name) {[weak self] result in
            switch result {
            case .success(_):
                if self?.resourceInfos.isEmpty ?? true {
                    return
                }
                self?.resourceInfos.removeFirst()
                self?.numberOfDownloadedReosurce += 1
                DispatchQueue.main.async {
                    self?.progressMessage = "\(String(self?.numberOfDownloadedReosurce ?? 0))/\(String(self?.numberOfResource ?? 0))"
                }
                self?.downloadResource()
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showingDownloadingModal = false
                    self?.alertMessage = "リソースのダウンロードに失敗しました"
                    self?.showingAlert = true
                }
            }
        }
    }
    
    func setCharacter() {
        guard
            let charaDomain = character?.charaDomain,
            let charaName = character?.name else {
            return
        }
        
        UserDefaultsHandler.setCharaDomain(charaDomain: charaDomain)
        UserDefaultsHandler.setCharaName(charaName: charaName)
        NotificationCenter.default.post(name: NSNotification.setChara, object: nil, userInfo: nil)
    }
}
