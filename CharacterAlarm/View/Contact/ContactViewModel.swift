import Foundation

import UIKit
import SwiftUI

class ContactViewState: ObservableObject {
    private let discordRepository = DiscordRepository()
    private let keychainRepository = KeychainRepository()
    
    @Published var id: String = ""
    @Published var email: String = ""
    @Published var message: String = ""

    
    func onAppear() {
        id = keychainRepository.getUserID() ?? "???"
    }
    
    func sendMessage() {
        var content = ""
        content += "id: \(id)\n"
        content += "email: \(email)\n"
        content += "message: \(message)\n"

        let request = DiscordRequest(content: content)
        
        
        Task {
            do {
                try await discordRepository.sendMessageForContact(requestBody: request)
            } catch {
                
            }
        }
    }
}
