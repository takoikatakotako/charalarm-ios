import SwiftUI

struct NewsRow: View {
    let circleName: String
    let date: Date
    let message: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(date.description)
                Spacer()
                Text(circleName)
            }
            Text(message)
            .lineLimit(2)
        }
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(circleName: "旋風鬼", date: Date(), message: "sdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsdfsdfsfsfdsdfsdfsdfsfsfd")
            .previewLayout(.sizeThatFits)
    }
}
