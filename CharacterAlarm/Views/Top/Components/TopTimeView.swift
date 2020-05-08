import SwiftUI

struct TopTimeView: View {
    @State var currentDate = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(getTime())
                .foregroundColor(.white)
                .font(Font.system(size: 40))
            Text(getDayAndDayOfWeek())
                .foregroundColor(.white)
                .font(Font.system(size: 24))
            EmptyView()
        }
        .frame(width: 160, height: 160)
        .background(Color.black)
        .cornerRadius(80)
        .opacity(0.9)
        .onReceive(timer) { input in
            self.currentDate = input
        }
    }
    
    func getTime() -> String {
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: currentDate)
        let minute = calendar.component(.minute, from: currentDate)
        return String(format: "%02d", hour) + ":" + String(format: "%02d", minute)
    }
    
    func getDayAndDayOfWeek() -> String {
        let calendar = Calendar(identifier: .gregorian)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        return String(format: "%02d", month) + "/" + String(format: "%02d", day) + "(" + getDayOfWeek() + ")"
    }
    
    func getDayOfWeek() -> String {
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.component(.weekday, from: currentDate)
        let weekday = component - 1
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja")
        return String(formatter.weekdaySymbols[weekday].prefix(1))
    }
}

struct TopTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TopTimeView()
            .previewLayout(.sizeThatFits)
    }
}
