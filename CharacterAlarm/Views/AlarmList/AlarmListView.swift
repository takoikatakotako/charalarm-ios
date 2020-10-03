import SwiftUI

struct AlarmListView: View {
    @EnvironmentObject var appState2: AppState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject(initialValue: AlarmListViewModel()) var viewModel: AlarmListViewModel
    
    let uid: String
    
    init(uid: String) {
        self.uid = uid
    }
    
    var body: some View {
        List {
            ForEach(self.viewModel.alarms) { alarm in
                NavigationLink(destination: AlarmDetailView(alarm: alarm)) {
                    AlarmListRow(delegate: self, alarm: alarm)
                        .frame(height: 60.0)
                    // Text(alarm.name)
                }
            }
            .onDelete(perform: delete)
        }.listStyle(DefaultListStyle())
        .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("設定")
                }),
                trailing:
                HStack {
                    EditButton()
                    NavigationLink(destination: AlarmDetailView(alarm: viewModel.createNewAlarm())) {
                        Image(systemName: "plus")
                    }
                }
        ).onAppear {
            self.viewModel.fetchAlarms()
        }.alert(isPresented: self.$viewModel.showingAlert) {
            Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
        }
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            guard let alarmId = viewModel.alarms[offset].alarmId else {
                return
            }
            viewModel.deleteAlarm(alarmId: alarmId)
        }
    }
}

extension AlarmListView: AlarmListRowDelegate {
    func updateAlarmEnable(alarmId: Int, isEnable: Bool) {
        viewModel.updateAlarmEnable(alarmId: alarmId, isEnable: isEnable)
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView(uid: "xxxx")
    }
}
