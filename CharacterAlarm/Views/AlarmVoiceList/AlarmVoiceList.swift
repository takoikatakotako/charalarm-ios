import SwiftUI

struct AlarmVoiceList: View {
    var body: some View {
        NavigationView {
            List {
                Text("おはよう")
                Text("お疲れ様")
                Text("お疲れ様")
                Text("お疲れ様")
                Text("お疲れ様")
                Text("お疲れ様")
                Text("お疲れ様")
                Text("お疲れ様")
            }
            .navigationBarTitle("ボイス設定")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AlarmVoiceList_Previews: PreviewProvider {
    static var previews: some View {
        AlarmVoiceList()
    }
}
