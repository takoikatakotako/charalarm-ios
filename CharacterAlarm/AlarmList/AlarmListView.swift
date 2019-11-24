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
                    Button("Edit") {
                        print("Edit tapped!")
                    }

                    Button("+") {
                        print("+ tapped!")
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
