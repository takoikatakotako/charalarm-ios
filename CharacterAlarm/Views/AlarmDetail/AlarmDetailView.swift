import SwiftUI

fileprivate struct Dispachers {
    let alarmDispacher = AlarmActionDispacher()
}

fileprivate let dispachers = Dispachers()


struct AlarmDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: AlarmDetailViewModel

    // AlarmId を取得して、そこからフェッチした方が良い。あ
    // マルチログインに対応する予定ないし、いらんかも
    init(alarm: Alarm) {
        viewModel = AlarmDetailViewModel(alarm: alarm)
    }

    var body: some View {
        
        List {
            NavigationLink(destination: EditAlarmName(alarmName: viewModel.alarm.name, delegate: self)) {
                VStack(alignment: .leading) {
                    Text("アラーム名")
                    Text(viewModel.alarm.name)
                }.frame(height: 60.0)
            }

            NavigationLink(destination: EditAlarmTime(delegate: self, hour: viewModel.alarm.hour, minute: viewModel.alarm.minute) ) {
                VStack(alignment: .leading) {
                    Text("時間")
                    Text(viewModel.alarmTimeString)
                }.frame(height: 60.0)
            }

            NavigationLink(destination: EditAlarmDayOfWeek(delegate: self, dayOfWeeks: viewModel.alarm.dayOfWeeks)) {
                VStack(alignment: .leading) {
                    Text("曜日")
                    Text(viewModel.enableDaysString)
                }.frame(height: 60.0)
            }

//            NavigationLink(destination: EditAlarmTimeDifference(delegate: self, timeDifference: viewModel.alarm.timeDifference)) {
//                VStack(alignment: .leading) {
//                    Text("時差")
//                    Text("GMT + \(viewModel.alarm.timeDifference)")
//                }.frame(height: 60.0)
//            }
        }.navigationBarItems(trailing:
            HStack {
                Button("Save") {
                    self.viewModel.createOrUpdateAlarm()
                }
            }
        ).alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
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
    func updateDayOfWeek(dayOfWeeks: [DayOfWeek2]) {
         viewModel.updateDayOfWeek(dayOfWeeks: dayOfWeeks)
    }
}

//struct AlarmDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmDetailView(alarm: Alarm2(id: "2", hour: "1", minute: "3"))
//    }
//}
