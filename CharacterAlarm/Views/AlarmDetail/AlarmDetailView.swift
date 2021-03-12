import SwiftUI

struct AlarmDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: AlarmDetailViewModel
    
    // AlarmId を取得して、そこからフェッチした方が良い。あ
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
            VStack(alignment: .center) {
                VStack(spacing: 0) {
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
                    
                    HStack {
                        Spacer()
                        Text("GMT+9")
                    }
                }
                .padding()
            
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
                    Text(R.string.localizable.alarmAlarmName())
                    TextField(R.string.localizable.alarmPleaseEnterTheAlarmName(), text: $viewModel.alarm.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
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
