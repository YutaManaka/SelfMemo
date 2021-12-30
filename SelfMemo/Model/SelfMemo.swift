//
//  SelfMemo.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/29.
//

import Foundation
import RealmSwift

class Todo: Object, Identifiable {
    @Persisted var text = ""
}

extension Todo {
    // 追加
    static func addTodo(text: String) {
        let todo = Todo()
        todo.text = text
        
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(todo)
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
        return Array(todos)
    }
        
    // 削除
    static func deleteTodo(todo: Todo) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.delete(todo)
        }
    }
}
