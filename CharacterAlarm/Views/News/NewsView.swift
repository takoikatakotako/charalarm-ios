import SwiftUI

struct NewsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject(initialValue: NewsViewModel()) var viewModel: NewsViewModel

    var body: some View {
        NavigationView {
            
            List (viewModel.newsList) { news in
                NewsRow(news: news)
            }.navigationBarTitle("ニュース", displayMode: .inline)
                .navigationBarItems(leading:
                    Button("閉じる") {
                        self.presentationMode.wrappedValue.dismiss()
                }
            )
        }.onAppear {
            self.viewModel.fetchNews()
        }.alert(isPresented: self.$viewModel.showingAlert) {
            Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
