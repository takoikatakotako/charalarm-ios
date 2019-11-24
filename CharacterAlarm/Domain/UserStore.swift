import UIKit
import FirebaseAuth
import FirebaseFirestore

class UserStore {

    static func featchUser(uid: String, completion: @escaping (User?, NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection(User.collectionName).document(uid).getDocument { documentSnapshot, error in
            if let error = error {
                completion(nil, error as NSError)
            } else {
                guard let document = documentSnapshot else {
                    completion(nil, nil)
                    return
                }
                completion(User(id: uid, document: document), nil)
            }
        }
    }

    static func saveVoipToken(token: String, error: @escaping (NSError?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            error(NSError(domain: "domain", code: 500, userInfo: nil))
            return
        }

        let db = Firestore.firestore()
        let ref = db.collection(User.collectionName).document(user.uid)
        let data = [User.voipToken: token]
        ref.setData(data) { (err) in
            if err == nil {
                error(nil)
            } else {
                error(err as NSError?)
            }
        }
    }

    static func saveCharacterId(characterId: String, error: @escaping (NSError?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            error(NSError(domain: "domain", code: 500, userInfo: nil))
            return
        }

        let db = Firestore.firestore()
        let ref = db.collection(User.collectionName).document(user.uid)
        let data = [User.characterId: characterId]
        ref.setData(data) { (err) in
            if err == nil {
                error(nil)
            } else {
                error(err as NSError?)
            }
        }
    }
}
