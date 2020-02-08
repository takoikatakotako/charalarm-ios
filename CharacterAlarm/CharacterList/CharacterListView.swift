import SwiftUI
import UIKit
import SDWebImageSwiftUI
import FirebaseStorage

struct ProfileCell: View {
    let profile: Profile
    @State var urlString: String = ""
    var body: some View {
        ZStack {
            WebImage(url: URL(string: self.urlString))
                .resizable()
                .placeholder {
                    Image("profile")
                        .resizable()
            }
            .animation(.easeInOut(duration: 0.5))
            .transition(.fade)
            .scaledToFill()

            VStack {
                Spacer()
                Text(profile.name)
                    .font(Font.system(size: 20.0).bold())
                    .frame(maxWidth: .infinity, maxHeight: 32)
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    .opacity(0.8)
            }
        }.onAppear {
            self.featchImageUrl()
        }
    }

    func featchImageUrl() {
        let storage = Storage.storage()
        let pathReference = storage.reference(withPath: "character/\(profile.id)/profile.png")
        pathReference.downloadURL { url, error in
            if let error = error {
                // Handle any errors
                print(error)
            } else {
                guard let urlString = url?.absoluteString else {
                    return
                }
                self.urlString = urlString
            }
        }
    }
}

struct CharacterListView: View {
    @ObservedObject(initialValue: CharacterListViewModel()) var viewModel: CharacterListViewModel

    private let columns: Int = 3

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                ForEach(0..<self.viewModel.profiles.count/self.columns) { rowIndex in
                    HStack {
                        ForEach(0..<self.columns) { columnIndex in
                            self.getProfileCell(
                                profile: self.getProfile(rowIndex: rowIndex, columnIndex: columnIndex),
                                width: self.cellWidth(width: geometry.size.width),
                                height: self.cellHeight(width: geometry.size.width))
                        }
                    }
                }

                if (self.viewModel.profiles.count % self.columns > 0) {
                    HStack {
                        ForEach(0..<self.viewModel.profiles.count % self.columns) { lastColumnIndex in
                            self.getProfileCell(
                                profile: self.getProfile(lastColumnIndex: lastColumnIndex),
                                width: self.cellWidth(width: geometry.size.width),
                                height: self.cellHeight(width: geometry.size.width))
                        }
                        Spacer()
                    }
                }
            }
        }.padding()
    }

    private func getProfile(rowIndex: Int, columnIndex: Int) -> Profile {
        return viewModel.profiles[columns * rowIndex + columnIndex]
    }

    private func getProfile(lastColumnIndex: Int) -> Profile {
        return viewModel.profiles[self.columns * (viewModel.profiles.count / columns) + lastColumnIndex]
    }

    private func cellWidth(width: CGFloat) -> CGFloat {
        return width / CGFloat(columns)
    }

    private func cellHeight(width: CGFloat) -> CGFloat {
        return cellWidth(width: width) * 1.5
    }

    private func getProfileCell(profile: Profile, width: CGFloat, height: CGFloat) -> AnyView {
        return AnyView(NavigationLink(destination: ProfileView(profile: profile)) {
            ProfileCell(profile: profile)
                .frame(width: width, height: height)
                .border(Color.black, width: 2)
                .clipped()
        }.buttonStyle(PlainButtonStyle())
        )
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
