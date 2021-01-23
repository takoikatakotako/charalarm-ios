import SwiftUI

struct AlarmListView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject(initialValue: AlarmListViewModel()) var viewModel: AlarmListViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.alarms) { alarm in
                            Button(action: {
                                viewModel.editAlarm(alarm: alarm)
                            }){
                                AlarmListRow(delegate: self, alarm: alarm)
                            }
                        }
                    }
                }
                
                BannerView()
            }
            .onAppear {
                viewModel.fetchAlarms()
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
            }
            .sheet(
                isPresented: $viewModel.showingEditAlarmSheet,
                onDismiss: {
                    viewModel.fetchAlarms()
                }) {
                if let alarm = viewModel.selectedAlarm {
                    AlarmDetailView(alarm: alarm)
                } else {
                    Text("不明なエラーが発生しました。")
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading: CloseBarButton() {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing:
                    Button(action: {
                        viewModel.addAlarmButtonTapped()
                    }) {
                        Image("alarm-add-icon")
                            .renderingMode(.template)
                            .foregroundColor(Color("charalarm-default-green"))
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
