import Foundation

import UIKit
import SwiftUI

class ContactViewState: ObservableObject {
    @Published var text: String = "This is some editable text..."

}
