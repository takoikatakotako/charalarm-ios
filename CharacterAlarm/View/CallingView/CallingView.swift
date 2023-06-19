import SwiftUI

struct CallingView: View {
    
    @StateObject var viewState: CallingViewState

    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            
            
            
            Text("Calling...")
                .font(Font.system(size: 40).bold())
                .foregroundColor(.white)
            
            
            Button("きる") {
                viewState.xxxx()
            }
            
        }

    }
}

struct CallingView_Previews: PreviewProvider {
    static var previews: some View {
        CallingView(viewState: CallingViewState(charaID: nil, charaName: nil, callUUID: nil))
    }
}
