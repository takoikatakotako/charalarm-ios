import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct ProfileCell: View {
    let profile: Profile
    var body: some View {
        ZStack {
            Image("profile")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack {
                Spacer()
                Text(profile.name)
                    .font(Font.system(size: 20.0).bold())
                    .frame(maxWidth: .infinity, maxHeight: 32)
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    .opacity(0.8)
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
                            NavigationLink(destination: ProfileView(profile: self.getProfile(rowIndex: rowIndex, columnIndex: columnIndex))) {
                                ProfileCell(profile: self.getProfile(rowIndex: rowIndex, columnIndex: columnIndex))
                                    .frame(width: self.cellWidth(width: geometry.size.width),
                                           height: self.cellHeight(width: geometry.size.width))
                                    .border(Color.black, width: 2)
                                    .clipped()
                            }
                        }
                    }
                }

                if (self.viewModel.profiles.count % self.columns > 0) {
                    HStack {
                        ForEach(0..<self.viewModel.profiles.count % self.columns) { lastColumnIndex in
                            NavigationLink(destination: ProfileView(profile: self.getProfile(lastColumnIndex: lastColumnIndex))) {
                                ProfileCell(profile: self.getProfile(lastColumnIndex: lastColumnIndex))
                                    .frame(width: self.cellWidth(width: geometry.size.width),
                                           height: self.cellHeight(width: geometry.size.width))
                                    .border(Color.black, width: 2)
                                    .clipped()
                            }
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
}

//WebImage(url: URL(string: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic"))
//    .resizable()
//    .placeholder {
//        Image("profile")
//            .resizable()
//            .frame(width: 54, height: 54)
//}
//    .animation(.easeInOut(duration: 0.5)) // Animation Duration
//    .transition(.fade) // Fade Transition
//    .scaledToFit()
//    .frame(width: 54.0, height: 54, alignment: .center)

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
