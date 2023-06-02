import SwiftUI

struct CharacterListBanner: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                Text(R.string.localizable.characterPr())
                    .foregroundColor(Color.white)
                    .font(.system(size: 14))
                    .frame(width: 36, height: 20)
                    .background(Color.gray)
            }
            HStack {
                Spacer()
                Text(R.string.localizable.characterWantToPublishYourCharacter())
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                    .foregroundColor(Color(R.color.brownColor.name))
                    .padding(.horizontal, 44)
                    .padding(.vertical, 8)
                Spacer()
            }
        }
        .background(Color.white)
        .cornerRadius(4)
        .overlay(
              RoundedRectangle(cornerRadius: 4)
                  .stroke(Color.gray, lineWidth: 1)
          )
    }
}

struct CharacterListBanner_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListBanner()
            .previewLayout(.sizeThatFits)
    }
}
