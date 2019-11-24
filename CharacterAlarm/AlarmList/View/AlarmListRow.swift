import SwiftUI

struct AlarmListRow: View {
    @State private var showGreeting = true
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("21:30")
                    .font(Font.system(size: 20))
                Text("アラーム名")
                Text("毎日")
            }
            Spacer()
            Toggle(isOn: $showGreeting) {
                Text("")
            }.padding()
        }
    }
}

struct AlarmListRow_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListRow()
    }
}
