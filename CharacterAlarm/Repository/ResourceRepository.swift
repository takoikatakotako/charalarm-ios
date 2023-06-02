import Foundation

protocol ResourceRepositoryProtcol {
    func getSelfIntroductionUrlString(charaDomain: String) -> String
    func getCharaThumbnailUrlString(charaDomain: String) -> String
}

struct ResourceRepository: ResourceRepositoryProtcol {
    func getSelfIntroductionUrlString(charaDomain: String) -> String {
        return "\(RESOURCE_ENDPOINT)/\(charaDomain)/voice/self-introduction.caf"
    }
    
    func getCharaThumbnailUrlString(charaDomain: String) -> String {
        return "\(RESOURCE_ENDPOINT)/\(charaDomain)/image/thumbnail.png"
    }
}
