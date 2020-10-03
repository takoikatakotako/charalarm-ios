import SwiftUI

struct PageView<Page: View>: View {
    @EnvironmentObject var appState2: AppState
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
                .environmentObject(appState2)
            
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
                .padding(.bottom, 28)
            
            if currentPage == viewControllers.count - 1 {
                VStack {
                    Spacer()
                    Button(action: {
                        self.appState2.doneTutorial = true
                    }) {
                        Text("sssssss")
                    }
                    Spacer()
                }
            }
            
        }
    }
}

struct PageView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State var views = [Text("First"), Text("Second"), Text("Third")]
        var body: some View {
            PageView(views)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
