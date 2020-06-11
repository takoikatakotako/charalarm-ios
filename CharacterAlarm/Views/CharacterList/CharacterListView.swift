import SwiftUI
import UIKit
import SDWebImageSwiftUI
import FirebaseStorage

struct CharacterListView: View {
    @ObservedObject(initialValue: CharacterListViewModel()) var viewModel: CharacterListViewModel
    
    private let columns: Int = 3
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(0..<self.viewModel.characters.count/self.columns, id: \.self) { rowIndex in
                            HStack(spacing: 0) {
                                ForEach(0..<self.columns, id: \.self) { columnIndex in
                                    
                                    CharacterListRow(character: self.viewModel.characters[self.getIndex(rowIndex: rowIndex, columnIndex: columnIndex)])
                                        .frame(
                                            width: self.cellWidth(width: geometry.size.width),
                                            height: self.cellHeight(width: geometry.size.width))
                                        .clipped()
                                }
                            }
                        }
                        
                        if (self.viewModel.characters.count % self.columns > 0) {
                            HStack(spacing: 0) {
                                ForEach(0..<self.viewModel.characters.count % self.columns, id: \.self) { lastColumnIndex in
                                    CharacterListRow(character: self.viewModel.characters[self.getIndex(lastColumnIndex: lastColumnIndex)])
                                        .frame(
                                            width: self.cellWidth(width: geometry.size.width),
                                            height: self.cellHeight(width: geometry.size.width))
                                        .clipped()
                                }
                                Spacer()
                            }
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    Button(action: {
                        print("xxx")
                    }) {
                        CharacterListBanner()
                            .background(Color.white)
                            .frame(width: geometry.size.width - 32, height: 60)
                            .padding(.bottom, 24)
                    }
                }
            }
        }
        .background(Color("xxxxColor"))
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            self.viewModel.fetchCharacters()
        }
    }
    
    private func getIndex(rowIndex: Int, columnIndex: Int) -> Int {
        return columns * rowIndex + columnIndex
    }
    
    private func getIndex(lastColumnIndex: Int) -> Int {
        return self.columns * (viewModel.characters.count / columns) + lastColumnIndex
    }
    
    private func cellWidth(width: CGFloat) -> CGFloat {
        return width / CGFloat(columns)
    }
    
    private func cellHeight(width: CGFloat) -> CGFloat {
        return cellWidth(width: width) * 1.5
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
