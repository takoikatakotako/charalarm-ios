import SwiftUI

struct NewsListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject(initialValue: NewsListViewModel()) var viewModel: NewsListViewModel
    
    var body: some View {
        NavigationView {
            List (viewModel.newsList) { news in
                Button {
                    guard let url = URL(string: news.url) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    NewsRow(news: news)
                }
            }
            .navigationBarTitle("ニュース", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image("common-icon-close")
                                            .renderingMode(.template)
                                            .foregroundColor(Color("charalarm-default-gray"))
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
        NewsListView()
    }
}
