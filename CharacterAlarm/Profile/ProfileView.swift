import SwiftUI

struct ProfileIcon: View {
    var body: some View {
        Image("profile")
            .resizable()
            .scaledToFill()
            .clipped()
    }
}

struct ProfileRow: View {
    let title: String
    let text: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(Font.headline)
                    .foregroundColor(Color.gray)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                Text(text)
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 8)
            }
            Spacer()
        }.padding(.leading, 16)
    }
}

struct ProfileView: View {
    let profile: Profile
    @State var showMenuItem1 = false
    @State var showMenuItem2 = false
    @State var showMenuItem3 = false
    var body: some View {

        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                ProfileIcon()
                ProfileRow(title: "名前", text: profile.name)
                ProfileRow(title: "プロフィール", text: profile.description)
                ProfileRow(title: "サークル名", text: profile.circleName)
                ProfileRow(title: "CV", text: profile.voiceName)
            }

            ZStack(alignment: .bottomTrailing) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    Spacer()
                    if showMenuItem1 {
                        Button(action: {
                            print("Camera")
                        }) {
                            MenuItem(icon: "camera.fill")
                        }
                    }
                    if showMenuItem2 {
                        Button(action: {
                            print("Photo")
                        }) {
                            MenuItem(icon: "photo.on.rectangle")
                        }
                    }
                    if showMenuItem3 {
                        Button(action: {
                            print("Arrow")
                        }) {
                            MenuItem(icon: "square.and.arrow.up.fill")
                        }
                    }
                    Button(action: {
                        self.showMenu()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
                            .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                    }
                }
                .padding()
            }
        }
    }

    func showMenu() {
        withAnimation {
            self.showMenuItem3.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showMenuItem2.toggle()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                self.showMenuItem1.toggle()
            }
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: Profile())
    }
}
