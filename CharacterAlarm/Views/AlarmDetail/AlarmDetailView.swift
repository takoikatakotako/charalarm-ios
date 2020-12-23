import SwiftUI

struct AlarmDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: AlarmDetailViewModel
    @State var xxx: Bool = false
    
    // AlarmId を取得して、そこからフェッチした方が良い。あ
    // マルチログインに対応する予定ないし、いらんかも
    init(alarm: Alarm) {
        viewModel = AlarmDetailViewModel(alarm: alarm)
    }
    
    var body: some View {
        NavigationView {
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
                    Text("アラーム名")
                    TextField("アラーム名を入力してください", text: $viewModel.alarm.name)
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
                            Text("アラームを削除する")
                                .foregroundColor(Color.white)
                                .font(Font.system(size: 16).bold())
                                .frame(height: 46)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color("charalarm-default-pink"))
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
                            viewModel.createOrUpdateAlarm()
                        }) {
                            Text("保存")
                                .foregroundColor(Color("charalarm-default-green"))
                        }
                    }
            ).alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
            }
            .navigationBarHidden(false)
            .navigationBarTitle("アラーム追加", displayMode: .inline)
        }        
    }
}

extension AlarmDetailView: EditAlarmNameDelegate {
    func updateAlarmName(name: String) {
        viewModel.updateAlarmName(name: name)
    }
}

extension AlarmDetailView: EditAlarmTimeDelegate {
    func updateAlarmTime(hour: Int, minute: Int) {
        // viewModel.updateAlarmTime(hour: hour, minute: minute)
    }
}

extension AlarmDetailView: EditAlarmTimeDifferenceDelegate {
    func updateAlarmTimeDifference(timeDifference: Int) {
        // viewModel.updateTimeDifference(timeDifference: timeDifference)
    }
}

extension AlarmDetailView: EditAlarmDayOfWeekDelegate {
    func updateDayOfWeek(dayOfWeeks: [DayOfWeek]) {
        viewModel.updateDayOfWeek(dayOfWeeks: dayOfWeeks)
    }
}

//struct AlarmDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmDetailView(alarm: Alarm2(id: "2", hour: "1", minute: "3"))
//    }
//}
