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
                
                AdmobBannerView(adUnitID: AdmobAlarmListUnitId)
            }
            .onAppear {
                viewModel.fetchAlarms()
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text(R.string.localizable.commonClose())))
            }
            .sheet(
                isPresented: $viewModel.showingEditAlarmSheet,
                onDismiss: {
                    viewModel.fetchAlarms()
                }) {
                if let alarm = viewModel.selectedAlarm {
                    AlarmDetailView(alarm: alarm)
                } else {
                    Text(R.string.localizable.errorAnUnknownErrorHasOccurred())
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
                        Image(R.image.alarmAddIcon.name)
                            .renderingMode(.template)
                            .foregroundColor(Color(R.color.charalarmDefaultGreen.name))
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
