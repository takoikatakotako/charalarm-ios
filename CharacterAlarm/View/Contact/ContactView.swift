import SwiftUI

struct ContactView: View {
    @StateObject var viewState: ContactViewState

    var body: some View {
        ScrollView {
            VStack {
                TextEditor(text: $viewState.text)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 300)
                    .border(Color.black)

            }
        }
    }
}

#Preview {
    NavigationView {
        ContactView(viewState: ContactViewState())
    }
}
