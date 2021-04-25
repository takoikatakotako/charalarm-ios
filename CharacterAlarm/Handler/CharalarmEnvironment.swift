import Foundation

class CharalarmEnvironment {
    var fileHandler: FileHandlerProtcol
    var keychainHandler: KeychainHandlerProtcol
    var resourceHandler: ResourceHandlerProtcol
    var userDefaultsHandler: UserDefaultsHandlerProtocol
    init(fileHandler: FileHandlerProtcol = FileHandler(),
         keychainHandler: KeychainHandlerProtcol = KeychainHandler(),
         resourceHandler: ResourceHandlerProtcol = ResourceHandler(),
         userDefaultsHandler: UserDefaultsHandler = UserDefaultsHandler()) {
        self.fileHandler = fileHandler
        self.keychainHandler = keychainHandler
        self.resourceHandler = resourceHandler
        self.userDefaultsHandler = userDefaultsHandler
    }
}

var charalarmEnvironment = CharalarmEnvironment()