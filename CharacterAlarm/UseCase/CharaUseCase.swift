import Foundation

protocol CharaUseCaseProtcol {
    func getSelfIntroductionUrlString(charaID: String) -> String
    func getCharaThumbnailUrlString(charaID: String) -> String
}

struct CharaUseCase: CharaUseCaseProtcol {
    func getSelfIntroductionUrlString(charaID: String) -> String {
        return "\(environmentVariable.resourceEndpoint)/\(charaID)/self-introduction.caf"
    }
    
    func getCharaThumbnailUrlString(charaID: String) -> String {
        return "\(environmentVariable.resourceEndpoint)/\(charaID)/thumbnail.png"
    }
}
