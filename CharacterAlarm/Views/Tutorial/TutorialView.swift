import SwiftUI

struct TutorialView: View {
    let imageName: String
    let text: String
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(text)
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
            }
            Spacer()
        }
        .background(Color.gray)
        .edgesIgnoringSafeArea(.all)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(imageName: "snorlax", text: "This is Tutorial!")
    }
}
