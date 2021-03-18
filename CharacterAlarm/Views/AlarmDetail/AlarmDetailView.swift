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
                VStack(alignment: .center) {
                    HStack {
                        Picker(selection: $viewModel.alarm.hour, label: EmptyView()) {
                            ForEach(0 ..< 24) {
                                Text(String(format: "%02d", $0))
                                    .font(Font.system(size: 42).bold())
                            }
                        }.pickerStyle(WheelPickerStyle())
                        .labelsHidden()
                        .frame(width: 80, height: 200)
                        .clipped()
                        
                        Text(":")
                            .font(Font.system(size: 60).bold())
                            .padding()
                        
                        Picker(selection: $viewModel.alarm.minute, label: EmptyView()) {
                            ForEach(0 ..< 60) {
                                Text(String(format: "%02d", $0))
                                    .font(Font.system(size: 42).bold())
                            }
                        }.pickerStyle(WheelPickerStyle())
                        .labelsHidden()
                        .frame(width: 80, height: 200)
                        .clipped()
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Spacer()
                        Text("GMT+9")
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    
                    HStack {
                        AlarmDetailWeekdayButton(dayOfWeeks: $viewModel.alarm.dayOfWeeks, dayOfWeek: .MON)
                        AlarmDetailWeekdayButton(dayOfWeeks: $viewModel.alarm.dayOfWeeks, dayOfWeek: .TUE)
                        AlarmDetailWeekdayButton(dayOfWeeks: $viewModel.alarm.dayOfWeeks, dayOfWeek: .WED)
                        AlarmDetailWeekdayButton(dayOfWeeks: $viewModel.alarm.dayOfWeeks, dayOfWeek: .THU)
                        AlarmDetailWeekdayButton(dayOfWeeks: $viewModel.alarm.dayOfWeeks, dayOfWeek: .FRI)
                        AlarmDetailWeekdayButton(dayOfWeeks: $viewModel.alarm.dayOfWeeks, dayOfWeek: .SAT)
                        AlarmDetailWeekdayButton(dayOfWeeks: $viewModel.alarm.dayOfWeeks, dayOfWeek: .SUN)
                    }
                    
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
                                    WebImage(url: URL(string: "https://resource.charalarm.com/com.charalarm.yui/image/thumbnail.png"))
                                        .resizable()
                                        .frame(width: 64, height: 64)
                                        .cornerRadius(10)
                                    
                                    Button {
                                        print("XXXXXX")
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
                                            viewModel.sheet = .voiceList
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
                    }
                    .padding(.horizontal, 16)

                    Spacer()
                    
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
                
//                ProgressView()
//                    .scaleEffect(1.5, anchor: .center)
//                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
//                    .padding(36)
//                    .background(Color.black.opacity(0.5))
//                    .cornerRadius(24)
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
            .sheet(item: $viewModel.sheet) {_ in
                AlarmVoiceList()
            }
            .navigationBarHidden(false)
            .navigationBarTitle(title, displayMode: .inline)
        }        
    }
}


//struct AlarmDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmDetailView(alarm: Alarm2(id: "2", hour: "1", minute: "3"))
//    }
//}
