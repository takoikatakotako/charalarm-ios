import SwiftUI

struct BackBarButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            Image("common-back-icon")
                .renderingMode(.template)
                .foregroundColor(Color("charalarm-default-gray"))
        }
    }
}

struct BackBarButton_Previews: PreviewProvider {
    static var previews: some View {
        BackBarButton(action: {})
    }
}
