import SwiftUI


struct ProfileIcon: View {
    var body: some View {
        Image("profile")
            .resizable()
    }
}


struct ProfileView: View {
    var body: some View {
        List {
            Section(header: ProfileIcon()) {
                Text("XXXX")
                Text("XXXX")
                Text("XXXX")
                Text("XXXX")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
