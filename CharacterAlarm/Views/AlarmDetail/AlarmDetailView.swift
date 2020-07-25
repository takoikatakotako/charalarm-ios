import SwiftUI

fileprivate struct Dispachers {
    let alarmDispacher = AlarmActionDispacher()
}

fileprivate let dispachers = Dispachers()


struct AlarmDetailView: View {
    @ObservedObject var viewModel: AlarmDetailViewModel

    // AlarmId を取得して、そこからフェッチした方が良い。あ
    // マルチログインに対応する予定ないし、いらんかも
    init(alarm: Alarm2) {
        viewModel = AlarmDetailViewModel(alarm: alarm)
    }

    var body: some View {
        
        List {
                    Text("xxx")
//            NavigationLink(destination: EditAlarmName(alarmName: viewModel.alarmName, delegate: self)) {
//                VStack(alignment: .leading) {
//                    Text("アラーム名")
//                    Text(viewModel.alarmName)
//                }.frame(height: 60.0)
//            }
//
//            NavigationLink(destination: EditAlarmTime(delegate: self, hour: viewModel.alarm.hour, minute: viewModel.alarm.minute) ) {
//                VStack(alignment: .leading) {
//                    Text("時間")
//                    Text(viewModel.alarmTimeString)
//                }.frame(height: 60.0)
//            }
//
//            NavigationLink(destination: EditAlarmDayOfWeek(delegate: self, enableDayOfWeek: viewModel.alarm.enableDayObWeek)) {
//                VStack(alignment: .leading) {
//                    Text("曜日")
//                    Text(viewModel.alarm.enableDaysString)
//                }.frame(height: 60.0)
//            }
//
//            NavigationLink(destination: EditAlarmTimeDifference(delegate: self, timeDifference: viewModel.alarm.timeDifference)) {
//                VStack(alignment: .leading) {
//                    Text("時差")
//                    Text("GMT + \(viewModel.alarm.timeDifference)")
//                }.frame(height: 60.0)
//            }
        }.navigationBarItems(trailing:
            HStack {
                Button("Save") {
                    // dispachers.alarmDispacher.saveAlarm(alarm: self.viewModel.alarm)
                    // self.viewModel.showingAlert = true
                }
            }
        ).alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(""), message: Text("保存が完了しました"), dismissButton: .default(Text("閉じる")))
        }
    }
}

extension AlarmDetailView: EditAlarmNameDelegate {
    func updateAlarmName(name: String) {
        // viewModel.updateAlarmName(name: name)
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
    func updateDayOfWeek(enableDayOfWeek: EnableDayOfWeek) {
        // viewModel.updateDayOfWeek(enableDayOfWeek: enableDayOfWeek)
    }
}

//struct AlarmDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmDetailView(alarm: Alarm2(id: "2", hour: "1", minute: "3"))
//    }
//}
