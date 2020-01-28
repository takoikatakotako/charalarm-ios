import SwiftUI

struct TopTimeView: View {
    var body: some View {
        VStack {
            Text("01:29")
                .foregroundColor(.white)
                .font(Font.system(size: 40))
            Text("01/29(W)")
                .foregroundColor(.white)
            .font(Font.system(size: 28))
        }
        .frame(width: 152, height: 152)
        .background(Color.black)
        .cornerRadius(76)
        .opacity(0.9)
    }
}

struct TopTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TopTimeView()
    }
}
