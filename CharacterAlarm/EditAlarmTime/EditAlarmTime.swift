import SwiftUI

protocol  EditAlarmTimeDelegate {
    func updateAlarmTime(hour: Int, minute: Int)
}

struct EditAlarmTime: View {
    let delegate: EditAlarmTimeDelegate
    @State var hour: Int
    @State var minute: Int

    var body: some View {
        GeometryReader { geometry in
            HStack {
                Picker(selection: self.$hour, label: EmptyView()) {
                    ForEach(0 ..< 24) {
                        Text("\($0)")
                    }
                }.pickerStyle(WheelPickerStyle())
                    .onReceive([self.hour].publisher.first()) { (_) in
                        self.delegate.updateAlarmTime(hour: self.hour, minute: self.minute)
                }.labelsHidden()
                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                    .clipped()

                Picker(selection: self.$minute, label: EmptyView()) {
                    ForEach(0 ..< 60) {
                        Text("\($0)")
                    }
                }.pickerStyle(WheelPickerStyle())
                    .onReceive([self.minute].publisher.first()) { (_) in
                        self.delegate.updateAlarmTime(hour: self.hour, minute: self.minute)
                }.labelsHidden()
                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                    .clipped()
            }
        }.padding()
    }
}

struct MockEditAlarmTimeDelegate: EditAlarmTimeDelegate {
    func updateAlarmTime(hour: Int, minute: Int) {
    }
}

struct EditAlarmTime_Previews: PreviewProvider {
    static var previews: some View {
        EditAlarmTime(delegate: MockEditAlarmTimeDelegate(), hour: 8, minute: 30)
    }
}
