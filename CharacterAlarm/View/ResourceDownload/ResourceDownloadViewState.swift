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

                    progressMessage = "(\(index + 1)/\(chara.resources.count))"
                    
                    let fileName = fileURL.lastPathComponent
                    let fileData = try await fileRepository.downloadFile(url: fileURL)
                    try fileRepository.saveFile(directoryName: charaID, fileName: fileName, data: fileData)
                }
                
                
                mainMessage = "ダウンロードが完了しました"
                progressMessage = "100%"
                showDismissButton = true
                // 閉じるボタン追加

                
            } catch {
                
                mainMessage = "ダウンロードに失敗しました"
                showDismissButton = true

            }
                        
            
            
        }
    }
}
