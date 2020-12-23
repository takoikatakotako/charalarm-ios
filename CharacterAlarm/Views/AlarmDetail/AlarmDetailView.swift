import SwiftUI

struct AlarmDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: AlarmDetailViewModel
    @State var minute: Int = 0
    
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
                            Text("\($0)")
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
                            Text("\($0)")
                                .font(Font.system(size: 42).bold())
                        }
                    }.pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                    .frame(width: 80, height: 200)
                    .clipped()
                }
                .padding()
                
                HStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("月")
                    })
                    
                    Button(action: {}, label: {
                        Text("月")
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("月")
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("月")
                    })
                    
                    Button(action: {}, label: {
                        Text("月")
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("月")
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("月")
                    })
                }
                
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
        
        //        ZStack {
        //            List {
        //                NavigationLink(destination: EditAlarmName(alarmName: viewModel.alarm.name, delegate: self)) {
        //                    VStack(alignment: .leading) {
        //                        Text("アラーム名")
        //                        Text(viewModel.alarm.name)
        //                    }.frame(height: 60.0)
        //                }
        //
        //                NavigationLink(destination: EditAlarmTime(delegate: self, hour: viewModel.alarm.hour, minute: viewModel.alarm.minute) ) {
        //                    VStack(alignment: .leading) {
        //                        Text("時間")
        //                        Text(viewModel.alarmTimeString)
        //                    }.frame(height: 60.0)
        //                }
        //
        //                NavigationLink(destination: EditAlarmDayOfWeek(delegate: self, dayOfWeeks: viewModel.alarm.dayOfWeeks)) {
        //                    VStack(alignment: .leading) {
        //                        Text("曜日")
        //                        Text(viewModel.alarm.dayOfWeeksString)
        //                    }.frame(height: 60.0)
        //                }
        //            }
        //
        
        //
        //        }
        
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
