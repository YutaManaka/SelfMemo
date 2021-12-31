//
//  ListView.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/29.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel = ListViewModel.shared
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todos) { todo in
                    HStack {
                        Button {
                            viewModel.completeTodo(todo: todo)
                        } label: {
                            if(todo.completed) {
                                Image(systemName: "checkmark.square.fill")
                            .foregroundColor(.green)
                            } else {
                                Image(systemName: "square")
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        VStack {
                            Text(todo.text)
                            .font(.title3)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            viewModel.deleteTodo(todo: todo)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                    .onTapGesture {
                        viewModel.updatingTodo = todo
                        viewModel.text = todo.text
                        viewModel.displayAddView.toggle()
                    }
                }
                .onMove { (indexSet, index) in
                    self.viewModel.todos.move(fromOffsets: indexSet, toOffset: index)
                }
            }
            .navigationTitle("セルフメモ")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                        viewModel.displayAddView.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            .navigationBarItems(
                leading: EditButton()
            )
            .sheet(isPresented: $viewModel.displayAddView) {
                AddView()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

//func toggle() -> Void {
//    todo.completed = false
////        isChecked = !isChecked
//        UIImpactFeedbackGenerator(style: .medium)
//        .impactOccurred()
//    }
