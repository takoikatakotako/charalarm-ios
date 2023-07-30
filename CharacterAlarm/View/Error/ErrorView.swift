import SwiftUI

struct ErrorView: View {
    @StateObject var viewState: ErrorViewState

    var body: some View {
        Text("Sorry Unknown Error...")
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(viewState: ErrorViewState())
    }
}
