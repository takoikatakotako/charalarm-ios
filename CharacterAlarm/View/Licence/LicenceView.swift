import SwiftUI

struct LicenceView: View {
    @StateObject var viewState: LicenceViewState

    var body: some View {
        List {
            Section(header: Text(R.string.localizable.licenseCharacter())) {
                Button {
                    viewState.openZunZunProject()
                } label: {
                    Text("ずんだもん")
                }
                .buttonStyle(.plain)
            }
            
            Section(header: Text(R.string.localizable.licenseSoftware())) {
                Button {
                    viewState.openZunZunProject()
                } label: {
                    Text("VOICEVOX:ずんだもん")
                }
                .buttonStyle(.plain)
            }
            
            Section(header: Text(R.string.localizable.licenseOther())) {
                Text(R.string.localizable.licenseOtherDescription())
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct LicenceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LicenceView(viewState: LicenceViewState())
        }
    }
}
