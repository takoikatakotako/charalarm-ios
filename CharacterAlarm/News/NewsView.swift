import SwiftUI

struct NewsView: View {
    var body: some View {
        NavigationView {
            List {
                Text("ニュースその１")
                Text("ニュースその２")
                Text("ニュースその３")
                Text("ニュースその４")
                Text("ニュースその５")
            }.navigationBarTitle("ニュース", displayMode: .inline)
            .navigationBarItems(leading:
                    Button("閉じる") {
                        print("ニュース tapped!")
                }
            )
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
