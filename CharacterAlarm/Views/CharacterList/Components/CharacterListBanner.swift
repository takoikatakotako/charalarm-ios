//
//  CharacterListBanner.swift
//  CharacterAlarm
//
//  Created by junpei ono on 2020/06/12.
//

import SwiftUI

struct CharacterListBanner: View {
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                Text("PR")
                    .foregroundColor(Color.white)
                    .font(.system(size: 14))
                    .frame(width: 36, height: 20)
                    .background(Color.gray)
                Spacer()
            }
            HStack {
                Spacer()
                Text("あなたのキャラクターを\nこのアプリで公開してみませんか？\n詳しくはこちら！！")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                    .foregroundColor(Color("brownColor"))
                Spacer()
            }
        }
    }
}

struct CharacterListBanner_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListBanner()
    }
}
