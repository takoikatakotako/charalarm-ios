import SwiftUI

struct ContactView: View {
    @StateObject var viewState: ContactViewState

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContactView(viewState: ContactViewState())
}
