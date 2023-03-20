import SwiftUI
import SDWebImageSwiftUI

struct AlarmDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewState: AlarmDetailViewState
    
    var title: String {
        if viewState.alarm.alarmId == nil {
            return R.string.localizable.alarmAddAlarm()
        } else {
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
                        
                        if let alarmId = viewState.alarm.alarmId {
                            AlarmDetailDeleteAlarmButton(delegate: self, alarmId: alarmId)
                        }
                    }
                }
                
                if viewState.showingIndicator {
                    CharalarmActivityIndicator()
                }
                
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
                            viewState.createOrUpdateAlarm() {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text(R.string.localizable.commonSave())
                                .foregroundColor(Color(R.color.charalarmDefaultGreen.name))
                        }
                    }
            ).alert(isPresented: $viewState.showingAlert) {
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
    
    func showVoiceList(chara: Character) {
        viewState.showVoiceList(chara: chara)
    }
}

extension AlarmDetailView: AlarmVoiceListViewDelegate {
    func selectedRandomVoice(chara: Character) {
        viewState.setCharaAndCharaCall(chara: chara, charaCall: nil)
    }
    
    func selectedVoice(chara: Character, charaCall: CharaCallResponseEntity) {
        viewState.setCharaAndCharaCall(chara: chara, charaCall: charaCall)

    }
}

extension AlarmDetailView: AlarmDetailDeleteAlarmDelegate {
    func deleteAlarm(alarmId: Int) {
        viewState.deleteAlarm(alarmId: alarmId) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}


//struct AlarmDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmDetailView(alarm: Alarm2(id: "2", hour: "1", minute: "3"))
//    }
//}
