import SwiftUI

struct AlarmVoiceList: View {
    let chara: Character
    var body: some View {
        NavigationView {
            List {
                ForEach(chara.charaCallResponseEntities) { index in
                    Text(index.charaFileName)
                 }
            }
            .navigationBarTitle("ボイス設定")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AlarmVoiceList_Previews: PreviewProvider {
    static var previews: some View {
        AlarmVoiceList(chara: Character.mock())
    }
}
