import SwiftUI

struct AlarmDetailView: View {
    let uid: String
    @ObservedObject var viewModel: AlarmDetailViewModel

    // AlarmId を取得して、そこからフェッチした方が良い。
    init(uid: String, alarm: Alarm) {
        self.uid = uid
        viewModel = AlarmDetailViewModel(uid: uid, alarm: alarm)
    }

    var body: some View {
        List {
            NavigationLink(destination: EditAlarmName(alarmName: viewModel.alarmName, delegate: self)) {
                VStack(alignment: .leading) {
                    Text("アラーム名")
                    Text(viewModel.alarmName)
                }.frame(height: 60.0)
            }

            NavigationLink(destination: EditAlarmTime(delegate: self, hour: viewModel.alarm.hour, minute: viewModel.alarm.minute) ) {
                VStack(alignment: .leading) {
                    Text("時間")
                    Text(viewModel.alarmTimeString)
                }.frame(height: 60.0)
            }

            NavigationLink(destination: EditAlarmDayOfWeek(delegate: self, enableDayOfWeek: viewModel.alarm.enableDayObWeek)) {
                VStack(alignment: .leading) {
                    Text("曜日")
                    Text("日, 月, 火, 水, 木, 金, 土")
                }.frame(height: 60.0)
            }

            NavigationLink(destination: EditAlarmTimeDifference(delegate: self, timeDifference: viewModel.alarm.timeDifference)) {
                VStack(alignment: .leading) {
                    Text("時差")
                    Text("GMT + \(viewModel.alarm.timeDifference)")
                }.frame(height: 60.0)
            }
        }.navigationBarItems(trailing:
            HStack {
                Button("Save") {
                    self.viewModel.saveButton()
                }
            }
        )
    }
}

extension AlarmDetailView: EditAlarmNameDelegate {
    func updateAlarmName(name: String) {
        viewModel.updateAlarmName(name: name)
    }
}

extension AlarmDetailView: EditAlarmTimeDelegate {
    func updateAlarmTime(hour: Int, minute: Int) {
        viewModel.updateAlarmTime(hour: hour, minute: minute)
    }
}

extension AlarmDetailView: EditAlarmTimeDifferenceDelegate {
    func updateAlarmTimeDifference(timeDifference: Int) {
        viewModel.updateTimeDifference(timeDifference: timeDifference)
    }
}

extension AlarmDetailView: EditAlarmDayOfWeekDelegate {
    func updateDayOfWeek(enableDayOfWeek: EnableDayOfWeek) {
        viewModel.updateDayOfWeek(enableDayOfWeek: enableDayOfWeek)
    }
}

struct AlarmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmDetailView(uid: "xxxx", alarm: Alarm(uid: "xxx", token: "token"))
    }
}
