//
//  ContentView.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/28.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    var appModel: AppModel // AppModel を外部から受け取る
    @ObservedObject var textLines: RealmSwift.List<TextLine> // textLines を外部から受け取る
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach( textLines.freeze() ) { textLine in // appModel 内部で保持されている TextLine の全てを List の対象とする
                        NavigationLink(textLine.text, destination: TextDetailView(textLine: self.textLineFromID(id: textLine.id))) // TextLineで保持しているtextを表示
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button("Add", action: {
                        let newName = "name" + String(Int.random(in: 0...2000))
//                        let createCommand = CreateTextLineCommand(appModel: self.appModel, newTextLineText: newName)
//                        self.appModel.executeCommand(createCommand)
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
    // idからデータを探す
    func textLineFromID(id: String) -> TextLine {
        let realm = try! Realm()
        return realm.object(ofType: TextLine.self, forPrimaryKey: id)!
      }
}

// 編集画面
struct TextDetailView: View {
  @ObservedObject var textLine: TextLine
  @State private var tmpText = ""
  var body: some View {
    TextField(textLine.text, text: $tmpText, onCommit: {
      let realm = try! Realm()
      try! realm.write {
        textLine.text = tmpText
      }
    })
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appModel: .init(), textLines: .init())
    }
}
