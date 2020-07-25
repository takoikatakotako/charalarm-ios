import SwiftUI

fileprivate struct Dispachers {
    let alarmDispacher = AlarmActionDispacher()
}

fileprivate let dispachers = Dispachers()

struct AlarmListView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject(initialValue: AlarmListViewModel()) var viewModel: AlarmListViewModel

    let uid: String
    
    init(uid: String) {
        self.uid = uid
    }

    var body: some View {
        List {
            ForEach(self.viewModel.alarms, id: \.self) { alarm in
                Text("xxx")
//                NavigationLink(destination: AlarmDetailView(alarm: alarm)) {
//                    AlarmListRow(delegate: self, alarm: alarm)
//                        .frame(height: 60.0)
//                }
            }
            .onDelete(perform: delete)
        }.listStyle(DefaultListStyle())
            .navigationBarItems(trailing:
                HStack {
                    EditButton()
                    NavigationLink(destination: AlarmDetailView(alarm: Alarm2(id: "3", hour: 23, minute: 23))) {
                        Image(systemName: "plus")
                    }
                }
        ).onAppear {
            self.viewModel.fetchAlarms()
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
