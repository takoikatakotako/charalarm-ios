import SwiftUI

protocol AlarmVoiceListViewDelegate {
    func selectedRandomVoice(chara: Chara)
    func selectedVoice(chara: Chara, charaCall: CharaCallResponseEntity)
}

struct AlarmVoiceListView: View {
    let delegate: AlarmVoiceListViewDelegate
    @StateObject var viewModel: AlarmVoiceListViewModel
    @Environment(\.presentationMode) private var presentationMode

    init(chara: Chara, delegate: AlarmVoiceListViewDelegate) {
        _viewModel = StateObject(wrappedValue: AlarmVoiceListViewModel(chara: chara))
        self.delegate = delegate
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.chara.calls, id: \.self) { charaCall in
                    HStack(spacing: 8) {
                        Button(action: {
                            viewModel.playVoice(fileName: charaCall.voice)
                        }, label: {
                            Image(R.image.alarmVoicePlay.name)
                        })
                        .buttonStyle(PlainButtonStyle())
                        
                        HStack {
                            Text(charaCall.message)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // delegate.selectedVoice(chara: viewModel.chara, charaCall: call)
                        presentationMode.wrappedValue.dismiss()
                    }
                 }
            }
            .navigationBarTitle("\(viewModel.chara.name)のボイス")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct AlarmVoiceList_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmVoiceListView(chara: Character.mock(), delegate: MockAlarmVoiceListViewDelegate())
//    }
//}

struct MockAlarmVoiceListViewDelegate: AlarmVoiceListViewDelegate {
    func selectedRandomVoice(chara: Chara) {}
    func selectedVoice(chara: Chara, charaCall: CharaCallResponseEntity) {}
}

