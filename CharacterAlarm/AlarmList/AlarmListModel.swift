import Foundation

class AlarmListModel {
    func featchAlarms(uid: String, completion: @escaping ([Alarm], NSError?) -> Void) {
        AlarmStore.featchAlarms(uid: uid) { (alarms, error) in
            if let error = error {
                completion([], error)
                return
            }
            completion(alarms, nil)
        }
    }
}
