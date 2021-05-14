import SwiftUI
import GoogleMobileAds

struct AlarmListView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject(initialValue: AlarmListViewModel()) var viewModel: AlarmListViewModel

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .center) {
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
                    
                    if viewModel.showingIndicator {
                        CharalarmActivityIndicator()
                    }
                }

                AdmobBannerView(adUnitID: AdmobAlarmListUnitId)
            }
            .onAppear {
                viewModel.fetchAlarms()
            }
            .alert(item: $viewModel.alert) { item in
                switch item {
                case .ad:
                    return Alert(title: Text(""), message: Text("動画見てください！"), primaryButton: .default(Text("aaa"), action: {
                        print("Hello")
                    }), secondaryButton: .cancel())
                case let .error(_, message):
                    return Alert(title: Text(""), message: Text(message), dismissButton: .default(Text(R.string.localizable.commonClose())))
                }
            }
            .sheet(item: $viewModel.sheet, onDismiss: {
                viewModel.fetchAlarms()
            }, content: { item in
                switch item {
                case let .alarmDetail(alarm):
                    AlarmDetailView(alarm: alarm)
                }
            })
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
