import SwiftUI

protocol AlarmVoiceListViewDelegate {
    func selectedRandomVoice(chara: Character)
    func selectedVoice(chara: Character, charaCall: CharaCallResponseEntity)
}

struct AlarmVoiceListView: View {
    let delegate: AlarmVoiceListViewDelegate
    @StateObject var viewModel: AlarmVoiceListViewModel
    @Environment(\.presentationMode) private var presentationMode

    init(chara: Character, delegate: AlarmVoiceListViewDelegate) {
        _viewModel = StateObject(wrappedValue: AlarmVoiceListViewModel(chara: chara))
        self.delegate = delegate
    }
    
    var body: some View {
        NavigationView {
            List {
                HStack(spacing: 8) {
                    Button(action: {
                        viewModel.playRandomVoice()
                    }, label: {
                        Image(R.image.alarmVoicePlay.name)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    HStack {
                        Text("ランダム")
                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    delegate.selectedRandomVoice(chara: viewModel.chara)
                    presentationMode.wrappedValue.dismiss()
                }
                
//                ForEach(viewModel.chara.calls) { call in
//                    HStack(spacing: 8) {
//                        Button(action: {
//                             viewModel.playVoice(filePath: call.charaFilePath)
//                        }, label: {
//                            Image(R.image.alarmVoicePlay.name)
//                        })
//                        .buttonStyle(PlainButtonStyle())
//                        
//                        HStack {
//                            Text(call.charaFileMessage)
//                            Spacer()
//                        }
//                        .contentShape(Rectangle())
//                    }
//                    .contentShape(Rectangle())
//                    .onTapGesture {
//                        delegate.selectedVoice(chara: viewModel.chara, charaCall: call)
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                 }
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
    func selectedRandomVoice(chara: Character) {}
    func selectedVoice(chara: Character, charaCall: CharaCallResponseEntity) {}
}

