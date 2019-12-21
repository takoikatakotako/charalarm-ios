import SwiftUI

struct EditAlarmName: View {
    @State private var alarmName = ""
    var body: some View {
        VStack {
            TextField("あなたの名前", text: $alarmName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            Button(action: {
                print("Button Action")
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

struct EditAlarmName_Previews: PreviewProvider {
    static var previews: some View {
        EditAlarmName()
    }
}
