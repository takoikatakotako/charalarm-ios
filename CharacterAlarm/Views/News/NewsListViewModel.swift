import SwiftUI

class NewsListViewModel: ObservableObject {
    @Published var newsList: [News] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    let newsRepository: NewsRepository = NewsRepository()
    
    func fetchNews() {
        newsRepository.fetchNews { result in
            switch result {
            case let .success(news):
                self.newsList = news
            case .failure:
                self.alertMessage = R.string.localizable.newsFailedToGetTheNews()
                self.showingAlert = true
            }
        }
    }
}
