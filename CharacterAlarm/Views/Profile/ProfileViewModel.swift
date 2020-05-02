import Foundation
import CallKit
import SwiftUI

class ProfileViewModel: ObservableObject {
    let model: ProfileModel = ProfileModel()
    let callKitHandler: CallKitHandler = CallKitHandler()
    @Published var isCalling: Bool = false

    init() {
        callKitHandler.delegate = self
    }

    func call() {
        guard let sceneDelegate = getSceneDelegate() else {
            return
        }
        sceneDelegate.startCall()

        let provider = CXProvider(configuration: CXProviderConfiguration(localizedName: "井上結衣"))
        provider.setDelegate(callKitHandler, queue: nil)
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: "井上結衣")
        provider.reportNewIncomingCall(with: UUID(), update: update, completion: { error in
            print("Error")
            print(error ?? "nil")
            print("Error")
        })
    }

    private func getSceneDelegate() -> SceneDelegate? {
        guard let scene = UIApplication.shared.connectedScenes.first else {
            return nil
        }

        guard let sceneDelegate = scene.delegate as? SceneDelegate else {
            return nil
        }
        return sceneDelegate
    }
}

extension ProfileViewModel: CallkitHandlerDelegate {
    func callAnswer() {
        print("CallStart")
    }

    func callEnd() {
        print("CallEnd")
        guard let sceneDelegate = getSceneDelegate() else {
            return
        }
        sceneDelegate.endCall()
    }
}
