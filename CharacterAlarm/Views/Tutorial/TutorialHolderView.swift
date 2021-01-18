import SwiftUI

struct TutorialHolderView: View {
    @EnvironmentObject var appState: CharalarmAppState
    @ObservedObject(initialValue: TutorialHolderViewModel()) var viewModel: TutorialHolderViewModel

    var body: some View {
        NavigationView {
            TutorialFirstView()
                .environmentObject(appState)
        }
        .onAppear {
            viewModel.signUp()
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Close")))
        }
    }
}

struct TutorialHolderView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialHolderView()
    }
}
