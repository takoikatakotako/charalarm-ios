import Foundation

class FileHandler {
    static func saveFile(directoryName: String, fileName: String, data: Data) throws {
        
        guard let dir = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first else {
            throw FileHandlerError.directoryNotFound
        }
        let dirPath = dir.appendingPathComponent( directoryName )
        
        if !FileManager.default.fileExists(atPath: dirPath.path) {
            try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
        }
        
        let filePath = dirPath.appendingPathComponent( fileName )
        print(filePath)
        try data.write(to: filePath, options: .atomic)
    }

    static func getFileURL(directoryName: String, fileName: String) throws -> URL {
      guard let dir = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first else {
          throw FileHandlerError.directoryNotFound
      }
        let dirPath = dir.appendingPathComponent( directoryName )
        let filePath = dirPath.appendingPathComponent( fileName )
        return filePath
    }

    static func loadData(directoryName: String, fileName: String) throws -> Data {
        let filePath = try getFileURL(directoryName: directoryName, fileName: fileName)
        print(filePath)
        guard let data = try? Data(contentsOf: filePath) else {
            throw FileHandlerError.directoryNotFound
        }
        return data
    }
}
