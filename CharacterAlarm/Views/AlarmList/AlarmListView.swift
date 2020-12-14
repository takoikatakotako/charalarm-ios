import SwiftUI

struct AlarmListView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject(initialValue: AlarmListViewModel()) var viewModel: AlarmListViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(self.viewModel.alarms) { alarm in
                        NavigationLink(destination: AlarmDetailView(alarm: alarm)) {
                            AlarmListRow(delegate: self, alarm: alarm)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                self.viewModel.fetchAlarms()
            }
            //            .alert(isPresented: self.$viewModel.showingAlert) {
            //                Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
            //            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
    
    //    func delete(at offsets: IndexSet) {
    //        for offset in offsets {
    //            guard let alarmId = viewModel.alarms[offset].alarmId else {
    //                return
    //            }
    //            viewModel.deleteAlarm(alarmId: alarmId)
    //        }
    //    }
}

extension AlarmListView: AlarmListRowDelegate {
    func updateAlarmEnable(alarmId: Int, isEnable: Bool) {
        viewModel.updateAlarmEnable(alarmId: alarmId, isEnable: isEnable)
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView()
    }
}
