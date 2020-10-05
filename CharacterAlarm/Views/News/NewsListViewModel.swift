import SwiftUI

class NewsListViewModel: ObservableObject {
    
    @Published var newsList: [News] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func fetchNews() {
        NewsStore.fetchNews { result in
            switch result {
            case let .success(news):
                self.newsList = news
            case let .failure(error):
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
    }
}
