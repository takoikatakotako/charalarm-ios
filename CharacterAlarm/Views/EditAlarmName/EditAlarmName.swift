import SwiftUI

protocol  EditAlarmNameDelegate {
    func updateAlarmName(name: String)
}

struct EditAlarmName: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alarmName: String
    let delegate: EditAlarmNameDelegate
    var body: some View {
        VStack {
            TextField("アラーム名", text: $alarmName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                BackBarButton() {
                                    presentationMode.wrappedValue.dismiss()
                                }
        )
        .onDisappear {
            self.delegate.updateAlarmName(name: self.alarmName)
        }
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
