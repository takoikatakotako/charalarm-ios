import SwiftUI

struct AlarmListView: View {
    var body: some View {
        List {
            NavigationLink(destination: AlarmDetailView()) {
                AlarmListRow()
                    .frame(height: 60.0)
            }
        }.listStyle(DefaultListStyle())
            .navigationBarItems(trailing:
                HStack {
                    NavigationLink(destination: AlarmDetailView()) {
                        Image(systemName: "square.and.pencil")
                    }

                    NavigationLink(destination: AlarmDetailView()) {
                        Image(systemName: "plus")
                    }

                }
        )
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView()
    }
}
