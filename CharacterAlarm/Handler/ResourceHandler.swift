import Foundation

protocol ResourceHandlerProtcol {}

class ResourceHandler: ResourceHandlerProtcol {
    static func getSelfIntroductionUrlString(charaDomain: String) -> String {
        return "\(RESOURCE_ENDPOINT)/\(charaDomain)/voice/self-introduction.caf"
    }
    
    static func getCharaThumbnailUrlString(charaDomain: String) -> String {
        return "\(RESOURCE_ENDPOINT)/\(charaDomain)/image/thumbnail.png"
    }
}
