import Foundation

import UIKit
import SwiftUI

class ContactViewState: ObservableObject {
    let discordRepository = DiscordRepository()
    
    @Published var text: String = "This is some editable text..."

    
    func sendMessage() {
        let request = DiscordRequest(content: "Hello")
        
        Task {
            do {
                try await discordRepository.sendMessageForContact(requestBody: request)
            } catch {
                
            }
        }
    }
}
