import SwiftUI

protocol AlarmVoiceListViewDelegate {
    
}

struct AlarmVoiceListView: View {
    let chara: Character
    let viewModel = AlarmVoiceListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(chara.charaCallResponseEntities) { charaCallResponseEntity in
                    HStack(spacing: 0) {
                        Button(action: {
                             viewModel.playVoice(filePath: charaCallResponseEntity.charaFilePath)
                        }, label: {
                            Image(R.image.alarmVoicePlay.name)
                        })
                        .background(Color.red)
                        .buttonStyle(PlainButtonStyle())
                        
                        HStack {
                            Text(charaCallResponseEntity.charaFileName)
                            Spacer()
    //
                        }
                        .contentShape(Rectangle())

//                        Button {
//                            print("ssss")
//                        } label: {
//                            Text(charaCallResponseEntity.charaFileName)
//                            .frame(height: 52)
//                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
//                        }
//                        .background(Color.blue)
//                        .buttonStyle(PlainButtonStyle())

                        
                        // https://stackoverflow.com/questions/58500295/swiftui-pick-a-value-from-a-list-with-ontap-gesture
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("ssss")
                    }
                 }
            }
            .navigationBarTitle("\(chara.name)のボイス")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AlarmVoiceList_Previews: PreviewProvider {
    static var previews: some View {
        AlarmVoiceListView(chara: Character.mock())
    }
}
