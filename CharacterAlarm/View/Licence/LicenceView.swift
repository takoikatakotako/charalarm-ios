import SwiftUI

struct LicenceView: View {
    var body: some View {
        List {
            Section(header: Text("キャラクター")) {
                Text("ずんだもん")
            }
            
            Section(header: Text("ソフトウェア")) {
                Text("ずんだもん")
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
