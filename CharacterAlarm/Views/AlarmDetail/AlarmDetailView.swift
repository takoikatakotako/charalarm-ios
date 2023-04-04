import SwiftUI
import SDWebImageSwiftUI

struct AlarmDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewState: AlarmDetailViewState
    
    var title: String {
        switch viewState.type {
        case .create:
            return R.string.localizable.alarmAddAlarm()
        case .edit:
            return R.string.localizable.alarmEditAlarm()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .center) {
                        AlarmDetailTimePickerTemp(hour: $viewState.alarm.hour, minute: $viewState.alarm.minute)
                        
                        HStack {
                            Spacer()
                            Text("GMT+9")
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        
                        AlarmDetailWeekdaySelecter(dayOfWeeks: $viewState.alarm.dayOfWeeks)
                        
                        VStack(alignment: .leading) {
                            TextField(R.string.localizable.alarmPleaseEnterTheAlarmName(), text: $viewState.alarm.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        
                        AlarmDetailCharaSelecter(delegate: self, selectedChara: $viewState.selectedChara, charas: $viewState.characters)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        
                        AlarmDetailVoiceText(fileMessage: viewState.selectedCharaCall?.charaFileMessage ?? "ランダム")
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        
                        
                        if viewState.type == .edit {
                            AlarmDetailDeleteAlarmButton(delegate: self, alarmId: viewState.alarm.alarmID)
                        }
                    }
                }
                
                if viewState.showingIndicator {
                    CharalarmActivityIndicator()
                }
                
            }
            .onReceive(viewState.dismissRequest) { _ in
                presentationMode.wrappedValue.dismiss()
            }
            .onAppear {
                viewState.onAppear()
            }
            .navigationBarItems(
                leading: CloseBarButton() {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing:
                    HStack {
                        Button(action: {
                            viewState.createAlarm()
                        }) {
                            Text(R.string.localizable.commonSave())
                                .foregroundColor(Color(R.color.charalarmDefaultGreen.name))
                        }
                    }
            )
            .alert(isPresented: $viewState.showingAlert) {
                Alert(title: Text(""), message: Text(viewState.alertMessage), dismissButton: .default(Text("閉じる")))
            }
            .sheet(item: $viewState.sheet) { item in
                switch item {
                case let .voiceList(chara):
                    AlarmVoiceListView(chara: chara, delegate: self)
                }
            }
            .navigationBarHidden(false)
            .navigationBarTitle(title, displayMode: .inline)
        }        
    }
}

extension AlarmDetailView: AlarmDetailCharaSelecterDelegate {
    func setRandomChara() {
        viewState.setRandomChara()
    }
    
    func showVoiceList(chara: Chara) {
        viewState.showVoiceList(chara: chara)
    }
}

extension AlarmDetailView: AlarmVoiceListViewDelegate {
    func selectedRandomVoice(chara: Chara) {
        viewState.setCharaAndCharaCall(chara: chara, charaCall: nil)
    }
    
    func selectedVoice(chara: Chara, charaCall: CharaCallResponseEntity) {
        viewState.setCharaAndCharaCall(chara: chara, charaCall: charaCall)

    }
}

extension AlarmDetailView: AlarmDetailDeleteAlarmDelegate {
    func deleteAlarm(alarmId: UUID) {
        viewState.deleteAlarm()
    }
}


//struct AlarmDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmDetailView(alarm: Alarm2(id: "2", hour: "1", minute: "3"))
//    }
//}
