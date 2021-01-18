import SwiftUI

protocol AlarmListRowDelegate {
    func updateAlarmEnable(alarmId: Int, isEnable: Bool)
}

class AlarmListRowModel: ObservableObject {
    let alarmId: Int?
    let delegate: AlarmListRowDelegate?
    @Published var enable: Bool {
        didSet {
            guard let alarmId = alarmId else {
                return
            }
            self.delegate?.updateAlarmEnable(alarmId: alarmId, isEnable: enable)
        }
    }
    
    init (alarmId: Int?, enable: Bool, delegate: AlarmListRowDelegate) {
        self.enable = enable
        self.alarmId = alarmId
        self.delegate = delegate
    }
}

struct AlarmListRow: View {
    @ObservedObject var alarmListModel: AlarmListRowModel
    let alarm: Alarm
    
    init(delegate: AlarmListRowDelegate, alarm: Alarm) {
        self.alarm = alarm
        self.alarmListModel = AlarmListRowModel(alarmId: alarm.alarmId, enable: alarm.enable, delegate: delegate)
    }
    
    var backgroundColor: Color {
        return alarm.enable ? Color("alarm-card-background-green") : Color("charalarm-default-gray")
    }
    
    var toggleThumbColor: Color {
        return alarm.enable ? Color("alarm-card-background-green") : Color("charalarm-default-gray")
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text(alarm.name)
                    .font(Font.system(size: 20))
                Text("\(String(format: "%02d", alarm.hour)):\(String(format: "%02d", alarm.minute))")
                    .font(Font.system(size: 36).bold())
                Text(alarm.dayOfWeeksString)
                    .font(Font.system(size: 20))
            }
            .fixedSize(horizontal: true, vertical: false)
            .foregroundColor(Color.white)
            .padding(.leading, 16)
            
            HStack {
                Spacer()
                Toggle(isOn: $alarmListModel.enable) {
                    Text("")
                }.labelsHidden()
                .toggleStyle(ColoredToggleStyle(label: "", onColor: Color.white, offColor: Color.white, thumbColor: toggleThumbColor))
                .padding()
            }
        }
        .frame(height: 140)
        .background(backgroundColor)
        .cornerRadius(16)
        .padding(8)
    }
}

// ref: https://stackoverflow.com/questions/56479674/set-toggle-color-in-swiftui
struct ColoredToggleStyle: ToggleStyle {
    var label = ""
    var onColor = Color(UIColor.green)
    var offColor = Color(UIColor.systemGray5)
    var thumbColor = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Text(label)
            Spacer()
            Button(action: { configuration.isOn.toggle() } )
            {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        Circle()
                            .fill(thumbColor)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(1.5)
                            .offset(x: configuration.isOn ? 10 : -10))
                    .animation(Animation.easeInOut(duration: 0.1))
            }
        }
        .font(.title)
        .padding(.horizontal)
    }
}

struct MockAlarmListRowDelegate: AlarmListRowDelegate {
    func updateAlarmEnable(alarmId: Int, isEnable: Bool) {
        
    }
}

//struct AlarmListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmListRow(delegate: MockAlarmListRowDelegate(), alarm: Alarm(uid: "uid", token: ""))
//            .previewLayout(
//                .fixed(width: 320, height: 60))
//    }
//}
