import SwiftUI
import FirebaseRemoteConfig

struct RootView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @State var remoteConfig: RemoteConfig!
    
    var body: some View {
        ZStack {
            if appState.underMaintenance {
                MaintenanceView()
            } else if appState.requiredVersion > appState.appVersion {
                UpdateRequiredView()
            } else {
                if appState.doneTutorial {
                    TopView()
                        .environmentObject(appState)
                } else {
                    TutorialHolderView()
                        .environmentObject(appState)
                }
            }
        }.onAppear {
            remoteConfig = RemoteConfig.remoteConfig()
            let settings = RemoteConfigSettings()
            settings.minimumFetchInterval = 0
            remoteConfig.configSettings = settings
            remoteConfig.fetch { (status, error) in
                guard status != .success else {
                    return
                }
                remoteConfig.activate() {_,_ in
                    if remoteConfig["under_maintenance"].boolValue {
                        appState.underMaintenance = true
                    }
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
