import SwiftUI

struct AlarmVoiceListView: View {
    let chara: Character
    let viewModel = AlarmVoiceListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(chara.charaCallResponseEntities) { charaCallResponseEntity in
                    HStack {
                        Text(charaCallResponseEntity.charaFileName)
                        Spacer()
                        Button(action: {
                            viewModel.playVoice(filePath: charaCallResponseEntity.charaFilePath)
                        }, label: {
                            Text("▷")
                        })
                    }
                 }
            }
            .navigationBarTitle("ボイス設定")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AlarmVoiceList_Previews: PreviewProvider {
    static var previews: some View {
        AlarmVoiceListView(chara: Character.mock())
    }
}
