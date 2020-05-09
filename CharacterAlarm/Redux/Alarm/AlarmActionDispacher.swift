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
    
    func updateAlarmEnable(alarmId: String, isEnable: Bool) {
        var alarms = store.state.alarmState.alarms
        guard let index = alarms.firstIndex(where: { $0.id == alarmId}) else {
            return
        }
        alarms[index].isEnable = isEnable
        self.store.dispatch(action: AlarmAction.updateAlarmEnable(alarms))

        // DB も更新
        AlarmStore.save(alarm: alarms[index]) { error in
            guard let error = error else {
                return
            }
            // TODO: エラーハンドリング
            print(error)
            self.fetchAlarmList()
        }
    }
    
    func saveAlarm(alarm: Alarm) {
        var alarms = store.state.alarmState.alarms
        guard let index = alarms.firstIndex(where: { $0.id == alarm.id}) else {
            return
        }
        
        alarms[index] = alarm
        
        // 保存
        AlarmStore.save(alarm: alarm) { error in
            guard let error = error else {
                return
            }
            // TODO: エラーハンドリング
            print(error)
            self.fetchAlarmList()
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
