import UIKit
import SwiftUI

class NewsViewModel: ObservableObject {
    
    @Published var newsList: [News] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func fetchNews() {
        NewsStore.fetchNews { error, newsList in
            if let error = error {
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = error.localizedDescription
                }
                return
            }
            
            DispatchQueue.main.async {
                self.newsList = newsList
            }
        }
    }
}
