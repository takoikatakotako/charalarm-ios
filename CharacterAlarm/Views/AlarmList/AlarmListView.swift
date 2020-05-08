import SwiftUI

struct AlarmListView: View {
    let uid: String
    @ObservedObject var viewModel: AlarmListViewModel

    @EnvironmentObject var appState: AppState

    
    init(uid: String) {
        self.uid = uid
        viewModel = AlarmListViewModel(uid: uid)
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
//            self.viewModel.onAppear()
            
            print(self.appState.alarmState.alarms.count)
            
        }
    }

    func delete(at offsets: IndexSet) {
        viewModel.deleteAlarm(at: offsets)
    }
}

extension AlarmListView: AlarmListRowDelegate {
    func updateAlarmEnable(alarmId: String, isEnable: Bool) {
        viewModel.updateAlarmEnable(alarmId: alarmId, isEnable: isEnable)
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView(uid: "xxxx")
    }
}
