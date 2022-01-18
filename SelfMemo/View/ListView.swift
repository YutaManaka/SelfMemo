//
//  ListView.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/29.
//

import SwiftUI

struct ListView: View {
    init() {
        UITableView.appearance().backgroundColor = .white // Uses UIColor
    }
    @ObservedObject var viewModel = ListViewModel.shared
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color(red:128/256, green:216/256, blue:209/256))
                        .frame(maxWidth: .infinity, maxHeight: 8)
                // リスト
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
                        .listRowSeparatorTint(.black)
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
                // ツールバー
                .toolbar {
                    // ナビゲーションバー左
                    ToolbarItem(placement: .navigationBarLeading){
                        MyEditButton()
                    }
                    // ナビゲーションバー右
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.displayAddView.toggle()
                        }) {
                            Image("plus")
                                .renderingMode(.original)
                                .resizable()
                                .padding()
                                .frame(width: 80, height: 80, alignment: .trailing)
                        }
                        
                    }
                    // ボトムバー
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(action: {
                            viewModel.displaySettingView.toggle()
                        }) {
                            Image("setting")
                                .renderingMode(.original)
                                .resizable()
                                .padding(45)
                                .frame(width: 120, height: 120)
                        }
                    }
                    
                }
                .navigationViewStyle(StackNavigationViewStyle()) 
                // 追加画面
                .sheet(isPresented: $viewModel.displayAddView) {
                    AddView()
                }
                // 設定画面
                .sheet(isPresented: $viewModel.displaySettingView) {
                    SettingView()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

/// オリジナルEditButton
struct MyEditButton: View {
    @Environment(\.editMode) var editMode
    
    var body: some View {
        Button(action: {
            withAnimation() {
                if editMode?.wrappedValue.isEditing == true {
                    editMode?.wrappedValue = .inactive
                } else {
                    editMode?.wrappedValue = .active
                }
            }
        }) {
            if editMode?.wrappedValue.isEditing == true {
                Text("終了")
            } else {
                Text("並べ替え")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
