import SwiftUI

struct CallingView: View {
    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            Text("Calling...")
                .font(Font.system(size: 40).bold())
                .foregroundColor(.white)
        }

    }
}

struct CallingView_Previews: PreviewProvider {
    static var previews: some View {
        CallingView()
    }
}
