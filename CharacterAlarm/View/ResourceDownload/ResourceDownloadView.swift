import SwiftUI

struct ResourceDownloadView: View {
    @StateObject var viewState: ResourceDownloadViewState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Text(viewState.mainMessage)
            Text(viewState.progressMessage)

            
            if viewState.showDismissButton {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("閉じる")
                }
            }
        }
        .onAppear {
            viewState.onAppear()
        }
//        VStack {
//            if viewState.downloadError {
//                Text(R.string.localizable.profileFailedToDownloadResources())
//                    .font(Font.system(size: 24))
//                    .foregroundColor(Color.white)
//                Button {
//                    viewState.close()
//                } label: {
//                    Text(R.string.localizable.commonClose())
//                        .font(Font.system(size: 24))
//                        .foregroundColor(Color.white)
//                        .padding(.top, 16)
//                }
//            } else {
//                Text(R.string.localizable.profileDownloadingResources())
//                    .font(Font.system(size: 24))
//                    .foregroundColor(Color.white)
//                Text(viewState.progressMessage)
//                    .font(Font.system(size: 24))
//                    .foregroundColor(Color.white)
//
//                Button {
//                    viewState.cancel()
//                } label: {
//                    Text(R.string.localizable.commonCancel())
//                        .font(Font.system(size: 24))
//                        .foregroundColor(Color.white)
//                        .padding(.top, 16)
//                }
//            }
//        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//        .background(Color.black.opacity(0.6))
//        .edgesIgnoringSafeArea(.bottom)
    }
}

//struct ResourceDownloadView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResourceDownloadView(viewState: <#ResourceDownloadViewState#>)
//    }
//}
