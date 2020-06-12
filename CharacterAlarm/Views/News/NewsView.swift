import SwiftUI

struct NewsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            List {
                NewsRow(circleName: "旋風鬼", date: Date(), message: "エアコミケ企画　月が燈る頃、陵乱の如く　ぷち体験版　公開")
                NewsRow(circleName: "旋風鬼", date: Date(), message: "全作60%Off & 過去作紹介 などなど")
                NewsRow(circleName: "旋風鬼", date: Date(), message: "C98スペース頂けました")
                NewsRow(circleName: "旋風鬼", date: Date(), message: "つきとも制作中につき")
                NewsRow(circleName: "旋風鬼", date: Date(), message: "制作中作品紹介")
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
