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
                viewModel.fetchAlarms()
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("common-icon-close")
                            .renderingMode(.template)
                            .foregroundColor(Color("charalarm-default-gray"))
                    },
                trailing:
                    NavigationLink(destination: AlarmDetailView(alarm: viewModel.createNewAlarm())) {
                        Image("alarm-add-icon")
                            .renderingMode(.template)
                            .foregroundColor(Color("charalarm-default-gray"))
                    }
            )
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
        AlarmListView()
    }
}
