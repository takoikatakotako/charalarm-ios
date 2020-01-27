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
                        Spacer()
                        Button(action: {
                            self.showNews = true
                        }) {
                            Image("top-news")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }.sheet(isPresented: self.$showNews) {
                            NewsView()
                        }.frame(width: 60, height: 60, alignment: .bottomLeading)
                            .background(Color.red)
                        
                        Button(action: {
                            self.showConfig = true
                        }) {
                            Image("top-config")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }.sheet(isPresented: self.$showConfig) {
                            ConfigView()
                        }.frame(width: 60, height: 60, alignment: .bottomLeading)
                            .background(Color.red)
                    }.padding(24)
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
