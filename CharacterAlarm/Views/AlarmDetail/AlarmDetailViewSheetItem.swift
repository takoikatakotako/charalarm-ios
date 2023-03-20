import Foundation

enum AlarmDetailViewSheetItem: Identifiable {
    case voiceList(Character)
    var id: Int {
        switch self {
        case let .voiceList(character):
            return character.charaId
        }
    }
}
