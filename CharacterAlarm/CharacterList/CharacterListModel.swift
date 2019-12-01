import Foundation

class CharacterListModel {
    func featchProfiles(limit: Int, completion: @escaping ([Profile], NSError?) -> Void) {
        ProfileStore.featchProfiles(limit: 5) { (profiles, error) in
            completion(profiles, error)
        }
    }
}
