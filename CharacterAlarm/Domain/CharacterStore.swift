import UIKit
import FirebaseFirestore

class CharacterStore {
    static func featchCharacter(characterId: String, completion: @escaping (Character?, NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection(Character.collectionName).document(characterId).getDocument(completion: { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                return
            }
            let character = Character(id: document.documentID, document: document)
            completion(character, error as NSError?)
        })
    }

    static func featchCharacters(limit: Int, completion: @escaping ([Character], NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection(Character.collectionName).limit(to: limit).getDocuments { querySnapshot, error in
            var charactos: [Character] = []
            if let error = error {
                completion(charactos, error as NSError)
            } else {
                for document in querySnapshot!.documents {
                    let character = Character(id: document.documentID, document: document)
                    charactos.append(character)
                }
                completion(charactos, nil)
            }
        }
    }
}
