//
//  ListViewModel.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/29.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var displayAddView = false
    @Published var updatingTodo:Todo? = nil
    @Published var todos: [Todo] = []
    @Published var text = ""
    
    init () {
        fetchTodos()
    }
    
    func fetchTodos() {
        self.todos = Todo.fetchAllTodo()!
    }
    
    func addTodo() {
        Todo.addTodo(text: text)
        self.text = ""
        fetchTodos()
    }
    
    func updateTodo() {
        Todo.updateTodo(todo: updatingTodo!, newText: self.text)
        // 初期化
        self.text = ""
        updatingTodo = nil
        fetchTodos()
    }
    
    func cancel() {
        // 初期化
        self.text = ""
        updatingTodo = nil
        fetchTodos()
    }
    
    func deleteTodo(todo: Todo) {
        Todo.deleteTodo(todo: todo)
        fetchTodos()
    }
    
    static let shared = ListViewModel()
}
