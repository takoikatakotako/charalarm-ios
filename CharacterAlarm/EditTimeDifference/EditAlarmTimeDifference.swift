import SwiftUI

protocol  EditAlarmTimeDifferenceDelegate {
    func updateAlarmTimeDifference(timeDifference: Int)
}

struct EditAlarmTimeDifference: View {
    let delegate: EditAlarmTimeDifferenceDelegate
    @State var timeDifference: Int
    var body: some View {
        Picker(selection: $timeDifference, label: EmptyView()) {
            ForEach(0 ..< 24) {
                Text("\($0)")
            }
        }.pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .onReceive([self.timeDifference].publisher.first()) { timeDifference in
                self.timeDifference = timeDifference

        }
        .onDisappear {
            self.delegate.updateAlarmTimeDifference(timeDifference: self.timeDifference)
        }
    }
}

struct MockEditAlarmTimeDifferenceDelegate: EditAlarmTimeDifferenceDelegate {
    func updateAlarmTimeDifference(timeDifference: Int) {}
}

struct EditTimeDifference_Previews: PreviewProvider {
    static var previews: some View {
        EditAlarmTimeDifference(delegate: MockEditAlarmTimeDifferenceDelegate(), timeDifference: 9)
    }
}
