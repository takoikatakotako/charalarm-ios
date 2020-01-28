import SwiftUI

struct TopButtonContent: View {
    let imageName: String
    var body: some View {
        Group {
            Image(imageName)
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.black)
        .cornerRadius(16)
        .shadow(color: .black, radius: 4, x: 4, y: 4)
        .opacity(0.9)
    }
}

struct TopButton_Previews: PreviewProvider {
    static var previews: some View {
        TopButtonContent(imageName: "top-news")
    }
}
