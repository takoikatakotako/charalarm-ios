import UIKit
import FirebaseFirestore

class ProfileStore {
    static func featchProfile(characterId: String, completion: @escaping (Profile?, NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection(Profile.collectionName).document(characterId).getDocument { documentSnapshot, error in
            if let error = error {
                completion(nil, error as NSError)
            } else {
                guard let document = documentSnapshot else {
                    completion(nil, nil)
                    return
                }
                completion(Profile(id: document.documentID, document: document), nil)
            }
        }
    }
}
