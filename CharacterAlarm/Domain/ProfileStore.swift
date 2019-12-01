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

    static func featchProfiles(limit: Int, completion: @escaping ([Profile], NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection(Profile.collectionName).limit(to: limit).getDocuments { querySnapshot, error in
            var profiles: [Profile] = []
            if let error = error {
                completion(profiles, error as NSError)
            } else {
                for document in querySnapshot!.documents {
                    let profile = Profile(id: document.documentID, document: document)
                    profiles.append(profile)
                }
                completion(profiles, nil)
            }
        }
    }
}
