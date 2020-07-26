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
                NavigationLink(destination: AlarmDetailView(alarm: alarm)) {
//                     AlarmListRow(delegate: self, alarm: alarm)
//                         .frame(height: 60.0)
                    Text(alarm.name)
                }
            }
            .onDelete(perform: delete)
        }.listStyle(DefaultListStyle())
            .navigationBarItems(trailing:
                HStack {
                    EditButton()
                    NavigationLink(destination: AlarmDetailView(alarm: Alarm(alarmId: -1, enable: true, name: "13", hour: 24, minute: 35, dayOfWeeks: ["SUN"]))) {
                        Image(systemName: "plus")
                    }
                }
        ).onAppear {
            self.viewModel.fetchAlarms()
        }.alert(isPresented: self.$viewModel.showingAlert) {
            Alert(
                title: Text("エラー"),
                message: Text(self.viewModel.alertMessage),
                primaryButton: .default(Text("ボタンその１")) {
                    print("ボタンその１")
                }, secondaryButton: .destructive(Text("ボタンその２")) {
                    print("ボタンその２")
                })
        }
    }

    func delete(at offsets: IndexSet) {
        dispachers.alarmDispacher.deleteAlarms(at: offsets)
    }
}

extension AlarmListView: AlarmListRowDelegate {
    func updateAlarmEnable(alarmId: String, isEnable: Bool) {
        // dispachers.alarmDispacher.updateAlarmEnable(alarmId: alarmId, isEnable: isEnable)
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView(uid: "xxxx")
    }
}
