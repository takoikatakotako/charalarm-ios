import UIKit
import FirebaseFirestore

class AlarmStore {
//    static func save(alarm: Alarm, error: @escaping (NSError?) -> Void) {
//        let db = Firestore.firestore()
//        let ref = db.collection(Alarm.collectionName).document(alarm.id)
//        ref.setData(alarm.data) { (err) in
//            if err == nil {
//                error(nil)
//            } else {
//                error(err as NSError?)
//            }
//        }
//    }
//
//    static func featchAlarms(uid: String, completion: @escaping ([Alarm], NSError?) -> Void) {
//        let db = Firestore.firestore()
////        let ref = db.collection(Alarm.collectionName).whereField(Alarm.uid, isEqualTo: uid)
//        let ref = db.collection(Alarm.collectionName)
//        ref.getDocuments { querySnapshot, error in
//            var alarms: [Alarm] = []
//            if let error = error {
//                completion(alarms, error as NSError)
//            } else {
//                for document in querySnapshot!.documents {
//                    let alarm = Alarm(id: document.documentID, document: document)
//                    alarms.append(alarm)
//                }
//                completion(alarms, nil)
//            }
//        }
//    }
//
//    static func deleteAlarm(alarmId: Int, completion: @escaping (NSError?) -> Void) {
////        let db = Firestore.firestore()
////        let ref = db.collection(Alarm.collectionName).document(alarmId)
////        ref.delete { (error) in
////            completion(error as NSError?)
////        }
//    }
}
