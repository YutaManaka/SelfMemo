//
//  ContentView.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/28.
//

import SwiftUI
import RealmSwift

//struct ContentView: View {
//    var body: some View {
//        Text("Hello, world!")
//            .padding()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

struct ContentView: View {
    var appModel: AppModel // AppModel を外部から受け取る
    @ObservedObject var textLines: RealmSwift.List<TextLine> // textLines を外部から受け取る
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach( textLines ) { textLine in // appModel 内部で保持されている TextLine の全てを List の対象とする
                        Text("\(textLine.id)  \(textLine.text)") // TextLine で保持している id と text を表示
                    }
                }
                .navigationBarTitle("セルフメモ") // タイトル
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appModel: .init(), textLines: .init())
    }
}
