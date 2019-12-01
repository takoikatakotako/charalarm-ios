import Foundation

class CharacterListModel {
    func featchCharacters(limit: Int, completion: @escaping ([Character], NSError?) -> Void) {
        CharacterStore.featchCharacters(limit: 5) { (characters, error) in
            completion(characters, error)
        }
    }
}
