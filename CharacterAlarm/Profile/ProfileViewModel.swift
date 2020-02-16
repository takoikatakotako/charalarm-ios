import Foundation
import CallKit

class ProfileViewModel: ObservableObject {
    let model: ProfileModel = ProfileModel()
    let callKitHandler: CallkitHandler = CallkitHandler()

    init() {
    }

    func call() {
        let provider = CXProvider(configuration: CXProviderConfiguration(localizedName: "My App"))
        provider.setDelegate(callKitHandler, queue: nil)
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: "Pete Za")
        provider.reportNewIncomingCall(with: UUID(), update: update, completion: { error in
            print("Error")
            print(error)
            print("Error")
        })
    }
}
