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
            ScrollView {
                VStack(alignment: .center) {
                    AlarmDetailTimePicker(hour: $viewModel.alarm.hour, minute: $viewModel.alarm.minute)
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    
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
                    
                    VStack(alignment: .leading) {
                        Text("キャラクター")
                            .font(Font.system(size: 16).bold())
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            if viewModel.characters.isEmpty {
                                Text("Loading")
                            } else {
                                LazyHStack(spacing: 12) {
                                    if let chara = viewModel.selectedChara {
                                        WebImage(url: URL(string: chara.charaThumbnailUrlString))
                                            .resizable()
                                            .frame(width: 64, height: 64)
                                            .cornerRadius(10)
                                    } else {
                                        Text("?")
                                            .frame(width: 64, height: 64)
                                            .foregroundColor(Color.white)
                                            .font(Font.system(size: 24).bold())
                                            .background(Color(UIColor.lightGray))
                                            .cornerRadius(10)
                                    }
                                    
                                    Button {
                                        viewModel.setRandomChara()
                                    } label: {
                                        Text("?")
                                            .frame(width: 56, height: 56)
                                            .foregroundColor(Color.white)
                                            .font(Font.system(size: 24).bold())
                                            .background(Color(UIColor.lightGray))
                                            .cornerRadius(10)
                                            .padding(.top, 8)
                                    }
                                    
                                    ForEach(viewModel.characters) { character in
                                        Button {
                                            viewModel.showVoiceList(chara: character)
                                        } label: {
                                            WebImage(url: URL(string: character.charaThumbnailUrlString))
                                                .resizable()
                                                .frame(width: 56, height: 56)
                                                .cornerRadius(10)
                                                .padding(.top, 8)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(height: 64)
                        .padding(.bottom, 16)
                        
                        Text("ボイス")
                            .font(Font.system(size: 16).bold())
                        
                        Text("\(viewModel.selectedCharaCall?.charaFileMessage ?? "ランダム")")
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                        
                        if let alarmId = viewModel.alarm.alarmId {
                            VStack {
                                Spacer()
                                Button(action: {
                                    viewModel.deleteAlarm(alarmId: alarmId) {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }) {
                                    Text(R.string.localizable.alarmDeleteAlarm())
                                        .foregroundColor(Color.white)
                                        .font(Font.system(size: 16).bold())
                                        .frame(height: 46)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .background(Color(R.color.charalarmDefaultPink.name))
                                        .cornerRadius(28)
                                        .padding(.horizontal, 24)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
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

extension AlarmDetailView: AlarmVoiceListViewDelegate {
    func selectedRandomVoice(chara: Character) {
        viewModel.setCharaAndCharaCall(chara: chara, charaCall: nil)
    }
    
    func selectedVoice(chara: Character, charaCall: CharaCallResponseEntity) {
        viewModel.setCharaAndCharaCall(chara: chara, charaCall: charaCall)

    }
}


//struct AlarmDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmDetailView(alarm: Alarm2(id: "2", hour: "1", minute: "3"))
//    }
//}
