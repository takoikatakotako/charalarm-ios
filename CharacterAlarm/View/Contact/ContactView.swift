import SwiftUI

struct ContactView: View {
    @StateObject var viewState: ContactViewState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("ユーザーID")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color(.appMainText))
                    Text("89ba061-d8b8-4290-9b9c-0bd401b250ec")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color(.appMainText))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("お問い合わせ内容")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color(.appMainText))
                    
                    ZStack {
                        TextEditor(text: $viewState.text)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(Color(.appMainText))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 300)
                            .padding(8)
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
        }
        .background(Color(.appBackground))
        .toolbar(.visible, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            leading:
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.top, 4)
                            .padding(.trailing, 4)
                            .padding(.bottom, 4)
                            .foregroundStyle(Color.white)
                    }
                },
            trailing:
                HStack {
                    Button(action: {
                        viewState.sendMessage()
                    }) {
                        Text("送信")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.white)
                            .padding(4)
                    }
                }
        )
    }
}

#Preview {
    NavigationView {
        ContactView(viewState: ContactViewState())
    }
}
