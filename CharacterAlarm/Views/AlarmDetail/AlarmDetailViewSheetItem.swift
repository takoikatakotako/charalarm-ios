import Foundation

enum AlarmDetailViewSheetItem: Identifiable {
    case voiceList(Character)
    var id: String {
        switch self {
        case let .voiceList(character):
            return character.charaID
        }
    }
}
