import SwiftUI

struct ContentView: View {
    @State private var showNews: Bool = false
    @State private var showConfig: Bool = false
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()

            VStack {
                Image("normal")
                    .resizable()
                    .padding(.top, 140.0)
            }

            VStack {
                Button(action: {
                    self.showNews = true
                }) {
                    Image("top-news")
                }.sheet(isPresented: self.$showNews) {
                    NewsView()
                }.frame(width: 80, height: 80, alignment: .bottomLeading)
                    .background(Color.red)

                Button(action: {
                    self.showConfig = true
                }) {
                    Image("top-config")
                }.sheet(isPresented: self.$showConfig) {
                    ConfigView()
                }.frame(width: 80, height: 80, alignment: .bottomLeading)
                .background(Color.red)
            }
        }.edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
