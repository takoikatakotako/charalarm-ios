import SwiftUI

struct LicenceView: View {
    var body: some View {
        List {
            Section(header: Text(R.string.localizable.licenseCharacter())) {
                Button {
                    print(ZunZunProjectURLString)
                } label: {
                    Text("ずんだもん")
                }
            }
            
            Section(header: Text(R.string.localizable.licenseSoftware())) {
                Button {
                    print(VoiceVoxURLString)
                } label: {
                    Text("VOICEVOX")
                }
            }
            
            Section(header: Text("その他")) {
                Text(R.string.localizable.licenseOther())
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct LicenceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LicenceView()
        }
    }
}
