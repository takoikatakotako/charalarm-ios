import SwiftUI

struct AlarmListView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject(initialValue: AlarmListViewModel()) var viewModel: AlarmListViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.alarms) { alarm in
                        Button(action: {
                            viewModel.showingSheetForEdit = true
                        }, label: {
                            AlarmListRow(delegate: self, alarm: alarm)
                        })
                        .sheet(isPresented: $viewModel.showingSheetForEdit) {
                            AlarmDetailView(alarm: alarm)
                        }
                        .sheet(
                            isPresented: $viewModel.showingSheetForEdit,
                            onDismiss: {
                                viewModel.fetchAlarms()
                            }) {
                            AlarmDetailView(alarm: alarm)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchAlarms()
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
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
                    .sheet(
                        isPresented: $viewModel.showingSheetForNew,
                        onDismiss: {
                            viewModel.fetchAlarms()
                        }) {
                        AlarmDetailView(alarm: viewModel.createNewAlarm())
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
