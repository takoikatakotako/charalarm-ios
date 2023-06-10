import Foundation

struct LocalCharaResourceUseCase {
    private let fileRepository = FileRepository()
    
    
    func saveCharaResource(charaID: String, localCharaResource: LocalCharaResource) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(localCharaResource)
        try fileRepository.saveFile(directoryName: charaID, fileName: "resource.json", data: data)
    }
    
}
