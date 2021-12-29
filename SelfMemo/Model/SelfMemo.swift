//
//  SelfMemo.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/29.
//

import Foundation
import RealmSwift


// DB定義
class TextLine: Object, Identifiable {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var text: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class TextLines: Object {
    @objc dynamic var id: Int = 0
    let textLines = List<TextLine>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

// Model
class AppModel: NSObject, ObservableObject {
    @Published var textLineList:List<TextLine>

    override init() {
        let realm = try! Realm()
        var textLines = realm.object(ofType: TextLines.self, forPrimaryKey: 0)
        if textLines == nil {
            textLines = try! realm.write{ realm.create(TextLines.self, value: [])}
        }
        self.textLineList = textLines!.textLines
        super.init()
        //デバッグ用
        if textLines!.textLines.count < 4 {
            self.createTestData(10)
        }
    }
    // デバッグ用
    func addTextLine(_ text:String) {
            let newText = TextLine()
            newText.text = text
            self.addTextLine(newText)
        }
        
    func addTextLine(_ textLine: TextLine) {
        let realm = try! Realm()
        try! realm.write {
            textLineList.append(textLine)
            realm.add(textLine)
        }
    }
    public func createTestData(_ num: Int) {
        for _ in 0 ..< num {
            let newText = TextLine()
            newText.text = Date().debugDescription
            self.addTextLine(newText)
        }
    }
    // デバッグ用終わり
}


