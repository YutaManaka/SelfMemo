//
//  SelfMemo.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/29.
//

import Foundation
import RealmSwift

class Todo: Object, Identifiable {
    @objc dynamic var text = ""
    @objc dynamic var completed = false
}

extension Todo {
    // 追加
    static func addTodo(text: String) {
        let todo = Todo()
        todo.text = text
        todo.completed = false
        
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(todo)
        }
    }
    
    // サンプルデータ作成(デバッグ用)
    static func createTestData(i num: Int) {
        for i in 0 ..< num {
            let newText = Todo()
            newText.text = "テスト\(i + 1)"
            self.addTodo(text: newText.text)
        }
    }
    
    // 更新
    static func updateTodo(todo: Todo, newText: String) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            todo.text = newText
        }
    }
    
    // 全件取得
    static func fetchAllTodo() -> [Todo]? {
        guard let localRealm = try? Realm() else { return nil }
        let todos = localRealm.objects(Todo.self)
            .filter("completed = false")
        return Array(todos)
    }
        
    // 削除
    static func deleteTodo(todo: Todo) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.delete(todo)
        }
    }
    
    // 完了
    static func completeTodo(todo: Todo) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            todo.completed = true
        }
    }
}
