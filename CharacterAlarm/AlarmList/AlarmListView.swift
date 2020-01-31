import SwiftUI

struct AlarmListView: View {
    let uid: String
    @ObservedObject var viewModel: AlarmListViewModel

    init(uid: String) {
        self.uid = uid
        viewModel = AlarmListViewModel(uid: uid)
    }

    var body: some View {
        List {
            ForEach(viewModel.alarms, id: \.self) { alarm in
                NavigationLink(destination: AlarmDetailView(uid: self.uid, alarm: alarm)) {
                    AlarmListRow(alarm: alarm)
                    .frame(height: 60.0)
                }
            }
            .onDelete(perform: delete)
        }.listStyle(DefaultListStyle())
            .navigationBarItems(trailing:
                HStack {
                    EditButton()
                    NavigationLink(destination: AlarmDetailView(uid: uid, alarm: Alarm(uid: uid, token: "xxx"))) {
                        Image(systemName: "plus")
                    }
                }
        )
            .onAppear {
                self.viewModel.onAppear()
        }
    }

    func delete(at offsets: IndexSet) {
        viewModel.deleteAlarm(at: offsets)
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView(uid: "xxxx")
    }
}
