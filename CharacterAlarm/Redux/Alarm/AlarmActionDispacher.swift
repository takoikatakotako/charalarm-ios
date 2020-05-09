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
    
    func deleteAlarms(at offsets: IndexSet) {
        let oldAlarms = store.state.alarmState.alarms
        var newAlarms = oldAlarms
        for offset in offsets {
            newAlarms.remove(at: offset)
        }
        self.store.dispatch(action: AlarmAction.deleteAlarms(newAlarms))
        
        // DB からも削除
        for offset in offsets {
            let alarmId = oldAlarms[offset].id
            AlarmStore.deleteAlarm(alarmId: alarmId) { error in
                guard let error = error else {
                    return
                }
                // TODO: エラーハンドリング
                print(error)
                self.fetchAlarmList()
            }
        }
    }
}
