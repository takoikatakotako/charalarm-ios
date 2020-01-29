import SwiftUI

protocol  EditAlarmNameDelegate {
    func updateAlarmName(name: String)
}

struct EditAlarmName: View {
    @State var alarmName: String
    let delegate: EditAlarmNameDelegate
    var body: some View {
        VStack {
            TextField("アラーム名", text: $alarmName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            Button(action: {
                self.delegate.updateAlarmName(name: self.alarmName)
            }, label: {
                HStack {
                    Spacer()
                    Text("EditAlarmName")
                        .foregroundColor(Color.white)
                    Spacer()
                }.frame(height: 40)
                    .background(Color.black)
            })
            Spacer()
        }
        .padding()
    }
}

struct MockEditAlarmNameDelegate: EditAlarmNameDelegate {
    func updateAlarmName(name: String) {
    }
}

struct EditAlarmName_Previews: PreviewProvider {
    static var previews: some View {
        EditAlarmName(alarmName: "アラーム名", delegate: MockEditAlarmNameDelegate())
    }
}
