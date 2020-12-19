import SwiftUI

struct CloseBarButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            Image("common-icon-close")
                .renderingMode(.template)
                .foregroundColor(Color("charalarm-default-gray"))
        }
    }
}

struct CloseBarButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseBarButton(action: {})
    }
}
