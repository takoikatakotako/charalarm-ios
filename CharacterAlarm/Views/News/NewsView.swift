import SwiftUI

struct NewsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    init() {
        UINavigationBar.appearance().tintColor = UIColor(named: AssetColor.textColor.rawValue)
    }

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
                        self.presentationMode.wrappedValue.dismiss()
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
