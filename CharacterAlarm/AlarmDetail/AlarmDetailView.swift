import SwiftUI

struct AlarmDetailView: View {
    var body: some View {
        List {
            NavigationLink(destination: EditAlarmName()) {
                VStack(alignment: .leading) {
                    Text("アラーム名")
                    Text("2019-10-06 06:10:24")
                }.frame(height: 60.0)
            }

            NavigationLink(destination: EditAlarmTime()) {
                VStack(alignment: .leading) {
                    Text("時間")
                    Text("16:10(GMT+9)")
                }.frame(height: 60.0)
            }

            NavigationLink(destination: EditAlarmWeekDay()) {
                VStack(alignment: .leading) {
                    Text("曜日")
                    Text("日, 月, 火, 水, 木, 金, 土")
                }.frame(height: 60.0)
            }

            NavigationLink(destination: EditAlarmTimeDifference()) {
                VStack(alignment: .leading) {
                    Text("時差")
                    Text("GMT + 9")
                }.frame(height: 60.0)
            }
        }.navigationBarItems(trailing:
                HStack {
                    Button("Save") {
                        print("Save tapped!")
                    }
            }
        )
    }
}

struct AlarmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmDetailView()
    }
}
