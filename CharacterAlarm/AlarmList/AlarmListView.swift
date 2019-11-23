import SwiftUI

struct AlarmListView: View {
    var body: some View {
        List {
            AlarmListRow()
            AlarmListRow()
            AlarmListRow()
        }.listStyle(DefaultListStyle())
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView()
    }
}
