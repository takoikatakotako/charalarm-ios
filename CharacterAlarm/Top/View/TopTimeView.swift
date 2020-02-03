import SwiftUI

struct TopTimeView: View {
    @State private var hour: Int = 0
//    @State var minute: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init() {
        let date = Date()
        let calendar = Calendar.current

//        self.hour = 0
        // hour = calendar.component(.hour, from: date)
//        minute = calendar.component(.minute, from: date)
    }

    var body: some View {
        VStack {
            Text("01:29")
                .foregroundColor(.white)
                .font(Font.system(size: 40))
            Text("01/29(W)")
                .foregroundColor(.white)
                .font(Font.system(size: 28))
        }
        .frame(width: 160, height: 160)
        .background(Color.black)
        .cornerRadius(80)
        .opacity(0.9)
        .onReceive(timer) { _ in
//            self.currentDate = input
//            print(self.currentDate)
        }
    }
}

struct TopTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TopTimeView()
            .previewLayout(.fixed(width: 160, height: 160))
    }
}
