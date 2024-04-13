import SwiftUI

struct ContactView: View {
    @StateObject var viewState: ContactViewState

    var body: some View {
        ScrollView {
            VStack {
                
                VStack(alignment: .leading) {
                    Text("ユーザーID")
                    Text("89ba061-d8b8-4290-9b9c-0bd401b250ec")
                }
                
                VStack(alignment: .leading) {
                    Text("お問い合わせ内容")
                    TextEditor(text: $viewState.text)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 300)

                }
            }
            .padding(.horizontal, 16)
        }
        .background(Color.gray)
    }
}

#Preview {
    NavigationView {
        ContactView(viewState: ContactViewState())
    }
}
