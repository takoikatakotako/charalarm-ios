import Foundation

class ResourceDownloadViewState: ObservableObject {
    private let charaID: String
    private let charaRepository = CharaRepository()
    private let fileRepository = FileRepository()
    
    @Published var mainMessage: String = "リソースをダウンロードしています"
    @Published var progressMessage: String = ""
    @Published var showDismissButton = false
    
    
    init(charaID: String) {
        self.charaID = charaID
    }
    
    func onAppear() {
        Task { @MainActor in
            do {
                let chara = try await charaRepository.fetchCharacter(charaID: charaID)
                for (index, resource) in chara.resources.enumerated() {
                    guard let fileURL = URL(string: resource.fileURL) else {
                        // TODO: エラーハンドリング
                        mainMessage = "ダウンロードに失敗しました"
                        progressMessage = ""
                        showDismissButton = true
                        return
                    }

                    let progressPercent = Int(round(Float(index + 1) / Float(chara.resources.count) * 100))
                    progressMessage = "\(progressPercent)%"
                    
                    let fileName = fileURL.lastPathComponent
                    let fileData = try await fileRepository.downloadFile(url: fileURL)
                    try fileRepository.saveFile(directoryName: charaID, fileName: fileName, data: fileData)
                }
                
                
                // Chara を CharaLocalResource に変換する
                let charaLocalResource = CharaLocalResource(chara: chara)
                let xxx = try JSONEncoder().encode(charaLocalResource)
                try fileRepository.saveFile(directoryName: chara.charaID, fileName: "resource.json", data: xxx)
                
                
                mainMessage = "設定完了しました"
                progressMessage = "100%"
                showDismissButton = true

                
                
                // 
                
                
                // ここでキャラクターを設定する
                
                
            } catch {
                
                mainMessage = "ダウンロードに失敗しました"
                showDismissButton = true

            }
        }
    }
}
