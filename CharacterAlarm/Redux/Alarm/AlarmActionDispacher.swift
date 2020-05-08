import Foundation

class AlarmActionDispacher {
    
    private let store: AppStore
    
    init(store: AppStore = mainStore) {
        self.store = store
    }
    
    func fetchAlarmList() {
        AlarmStore.featchAlarms(uid: "dammy") { (alarms, error) in
            self.store.dispatch(action: AlarmAction.fetchAlarmList(alarms))
        }
    }
}
