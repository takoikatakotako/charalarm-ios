import SwiftUI

struct AlarmListView: View {
    var body: some View {
        List {
            NavigationLink(destination: AlarmDetailView()) {
                AlarmListRow()
            }
        }.listStyle(DefaultListStyle())
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView()
    }
}
