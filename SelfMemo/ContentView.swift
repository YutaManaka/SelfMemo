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
                    ForEach( textLines.freeze() ) { textLine in // appModel 内部で保持されている TextLine の全てを List の対象とする
                        Text("\(textLine.text)") // TextLineで保持しているtextを表示
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button("Add", action: {
                        let newName = "name" + String(Int.random(in: 0...2000))
                        self.appModel.addTextLine(newName)
                    })
                )
                .navigationBarTitle("セルフメモ") // タイトル
            }
        }
    }
    // 削除
    func delete(at offsets:IndexSet) {
        if let realm = textLines.realm {
            try! realm.write {
                realm.delete(textLines[offsets.first!])
            }
        } else {
            textLines.remove(at: offsets.first!)
        }
    }
    // 移動
    func move(fromOffsets offsets: IndexSet, toOffset to: Int) {
        textLines.realm?.beginWrite()
        textLines.move(fromOffsets: offsets, toOffset: to)
        try! textLines.realm?.commitWrite()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appModel: .init(), textLines: .init())
    }
}
