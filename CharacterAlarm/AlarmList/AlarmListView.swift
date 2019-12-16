import SwiftUI

struct AlarmListView: View {
    let uid: String
    @ObservedObject var viewModel: AlarmListViewModel

    init(uid: String) {
        self.uid = uid
        viewModel = AlarmListViewModel(uid: uid)
    }

    var body: some View {
        List(viewModel.alarms) {_ in
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
        AlarmListView(uid: "xxxx")
    }
}
