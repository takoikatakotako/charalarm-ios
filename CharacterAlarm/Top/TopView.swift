import SwiftUI

struct TopView: View {
    @ObservedObject(initialValue: TopViewModel()) var viewModel: TopViewModel
    @State private var showNews: Bool = false
    @State private var showConfig: Bool = false
    var body: some View {

        GeometryReader { geometory in
            ZStack {
                Image("background")
                    .resizable()
                    .frame(width: geometory.size.width, height: geometory.size.height)
                    .scaledToFill()

                VStack {
                    Spacer()
                    Image("normal")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometory.size.width, height: geometory.size.height - 60)
                }

                Button(action: {
                    print("Action")
                }) {
                    Text("")
                        .frame(width: geometory.size.width, height: geometory.size.height)
                }

                VStack {
                    Spacer()
                    HStack {
                        TopTimeView()
                        Spacer()
                    }
                }
                .padding(24)

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
                    }.padding(24)
                }
            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone 11")
                .environment(\.colorScheme, .light)
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}
