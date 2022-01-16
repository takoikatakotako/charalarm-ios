import SwiftUI
import SDWebImageSwiftUI

struct AlarmDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: AlarmDetailViewModel
    
    // AlarmId を取得して、そこからフェッチした方が良い。
    // マルチログインに対応する予定ないし、いらんかも
    init(alarm: Alarm) {
        _viewModel = StateObject(wrappedValue: AlarmDetailViewModel(alarm: alarm))
    }
    
    var title: String {
        if viewModel.alarm.alarmId == nil {
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
//                        AlarmDetailTimePicker(hour: $viewModel.alarm.hour, minute: $viewModel.alarm.minute)
//                        .padding(.top, 16)
//                        .padding(.horizontal, 16)
                        AlarmDetailTimePickerTemp(hour: $viewModel.alarm.hour, minute: $viewModel.alarm.minute)
                        
                        HStack {
                            Spacer()
                            Text("GMT+9")
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        
                        AlarmDetailWeekdaySelecter(dayOfWeeks: $viewModel.alarm.dayOfWeeks)
                        
                        VStack(alignment: .leading) {
                            TextField(R.string.localizable.alarmPleaseEnterTheAlarmName(), text: $viewModel.alarm.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        
                        AlarmDetailCharaSelecter(delegate: self, selectedChara: $viewModel.selectedChara, charas: $viewModel.characters)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        
                        AlarmDetailVoiceText(fileMessage: viewModel.selectedCharaCall?.charaFileMessage ?? "ランダム")
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        
                        if let alarmId = viewModel.alarm.alarmId {
                            AlarmDetailDeleteAlarmButton(delegate: self, alarmId: alarmId)
                        }
                    }
                }
                
                if viewModel.showingIndicator {
                    CharalarmActivityIndicator()
                }
                
            }
            .onAppear {
                viewModel.onAppear()
            }
            .navigationBarItems(
                leading: CloseBarButton() {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing:
                    HStack {
                        Button(action: {
                            viewModel.createOrUpdateAlarm() {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text(R.string.localizable.commonSave())
                                .foregroundColor(Color(R.color.charalarmDefaultGreen.name))
                        }
                    }
            ).alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
            }
            .sheet(item: $viewModel.sheet) { item in
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
        viewModel.setRandomChara()
    }
    
    func showVoiceList(chara: Character) {
        viewModel.showVoiceList(chara: chara)
    }
}

extension AlarmDetailView: AlarmVoiceListViewDelegate {
    func selectedRandomVoice(chara: Character) {
        viewModel.setCharaAndCharaCall(chara: chara, charaCall: nil)
    }
    
    func selectedVoice(chara: Character, charaCall: CharaCallResponseEntity) {
        viewModel.setCharaAndCharaCall(chara: chara, charaCall: charaCall)

    }
}

extension AlarmDetailView: AlarmDetailDeleteAlarmDelegate {
    func deleteAlarm(alarmId: Int) {
        viewModel.deleteAlarm(alarmId: alarmId) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}


//struct AlarmDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmDetailView(alarm: Alarm2(id: "2", hour: "1", minute: "3"))
//    }
//}
