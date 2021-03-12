import Foundation

protocol ResourceHandlerProtcol {
    func getSelfIntroductionUrlString(charaDomain: String) -> String
    func getCharaThumbnailUrlString(charaDomain: String) -> String
}

class ResourceHandler: ResourceHandlerProtcol {
    func getSelfIntroductionUrlString(charaDomain: String) -> String {
        return "\(RESOURCE_ENDPOINT)/\(charaDomain)/voice/self-introduction.caf"
    }
    
    func getCharaThumbnailUrlString(charaDomain: String) -> String {
        return "\(RESOURCE_ENDPOINT)/\(charaDomain)/image/thumbnail.png"
    }
}
