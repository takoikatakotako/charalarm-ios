import SwiftUI

fileprivate struct Dispachers {
    let alarmDispacher = AlarmActionDispacher()
}

fileprivate let dispachers = Dispachers()

struct AlarmListView: View {
    @EnvironmentObject var appState: AppState
    let uid: String
    
    init(uid: String) {
        self.uid = uid
    }

    var body: some View {
        List {
            ForEach(appState.alarmState.alarms, id: \.self) { alarm in
                NavigationLink(destination: AlarmDetailView(uid: self.uid, alarm: alarm)) {
                    AlarmListRow(delegate: self, alarm: alarm)
                        .frame(height: 60.0)
                }
            }
            .onDelete(perform: delete)
        }.listStyle(DefaultListStyle())
            .navigationBarItems(trailing:
                HStack {
                    EditButton()
                    NavigationLink(destination: AlarmDetailView(uid: uid, alarm: Alarm(uid: uid, token: "xxx"))) {
                        Image(systemName: "plus")
                    }
                }
        ).onAppear {
            dispachers.alarmDispacher.fetchAlarmList()
        }
    }

    func delete(at offsets: IndexSet) {
        dispachers.alarmDispacher.deleteAlarms(at: offsets)
    }
}

extension AlarmListView: AlarmListRowDelegate {
    func updateAlarmEnable(alarmId: String, isEnable: Bool) {
        dispachers.alarmDispacher.updateAlarmEnable(alarmId: alarmId, isEnable: isEnable)
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView(uid: "xxxx")
    }
}
