import SwiftUI

protocol  EditAlarmTimeDifferenceDelegate {
    func updateAlarmTimeDifference(hour: Int)
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
    }
}

struct MockEditAlarmTimeDifferenceDelegate: EditAlarmTimeDifferenceDelegate {
    func updateAlarmTimeDifference(hour: Int) {}
}

struct EditTimeDifference_Previews: PreviewProvider {
    static var previews: some View {
        EditAlarmTimeDifference(delegate: MockEditAlarmTimeDifferenceDelegate(), timeDifference: 9)
    }
}
