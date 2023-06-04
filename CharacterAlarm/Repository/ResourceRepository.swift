import Foundation

protocol ResourceRepositoryProtcol {
    func getSelfIntroductionUrlString(charaDomain: String) -> String
    func getCharaThumbnailUrlString(charaDomain: String) -> String
}

struct ResourceRepository: ResourceRepositoryProtcol {
    func getSelfIntroductionUrlString(charaDomain: String) -> String {
        return "\(environmentVariable.resourceEndpoint)/\(charaDomain)/self-introduction.caf"
    }
    
    func getCharaThumbnailUrlString(charaDomain: String) -> String {
        return "\(environmentVariable.resourceEndpoint)/\(charaDomain)/thumbnail.png"
    }
}
