import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()

                VStack {
                    Image("normal")
                        .resizable()
                }

                VStack {

                    NavigationLink (destination: ConfigView()
                    .navigationBarTitle("Config", displayMode: .inline)
                    ) {
                        Image("top-config")
                    }
                }
            }.edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
