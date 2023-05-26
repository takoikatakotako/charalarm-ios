import Foundation

class CharalarmEnvironment {
    var fileHandler: FileHandlerProtcol
    var resourceHandler: ResourceHandlerProtcol
    init(fileHandler: FileHandlerProtcol = FileHandler(),
         resourceHandler: ResourceHandlerProtcol = ResourceHandler()) {
        self.fileHandler = fileHandler
        self.resourceHandler = resourceHandler
    }
}

var charalarmEnvironment = CharalarmEnvironment()
