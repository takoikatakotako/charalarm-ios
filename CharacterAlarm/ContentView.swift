import SwiftUI

struct ContentView: View {
    @State private var showNews: Bool = false
    @State private var showConfig: Bool = false
    var body: some View {
        GeometryReader { geometory in
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()

                VStack {
                    Spacer()
                    Image("normal")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometory.size.width, height: geometory.size.height - 100)
                }

                VStack {
                    Spacer()
                    HStack {
                        TopTimeView()
                        Spacer()
                    }
                }                    .padding(24)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            self.showNews = true
                        }) {
                            TopButtonContent(imageName: "top-news")
                        }.sheet(isPresented: self.$showNews) {
                            NewsView()
                        }

                        Button(action: {
                            self.showConfig = true
                        }) {
                            TopButtonContent(imageName: "top-config")
                        }.sheet(isPresented: self.$showConfig) {
                            ConfigView()
                        }
                    }
                    .padding(36)
                }
            }
        }.edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
