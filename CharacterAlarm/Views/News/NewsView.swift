import SwiftUI

struct NewsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            List {
                NewsRow(circleName: "旋風鬼", date: Date(), message: "sdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsfsfd")
                NewsRow(circleName: "旋風鬼", date: Date(), message: "sdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsfsfd")
                NewsRow(circleName: "旋風鬼", date: Date(), message: "sdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsfsfd")
                NewsRow(circleName: "旋風鬼", date: Date(), message: "sdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsfsfd")
                NewsRow(circleName: "旋風鬼", date: Date(), message: "sdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsfsfd")
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
