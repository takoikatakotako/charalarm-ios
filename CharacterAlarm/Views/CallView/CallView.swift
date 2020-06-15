import SwiftUI

struct CallView: View {
    let characterId: String
    let characterName: String
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CallView_Previews: PreviewProvider {
    static var previews: some View {
        CallView(characterId: "xxx", characterName: "yyy")
    }
}
