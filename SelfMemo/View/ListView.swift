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
        UIToolbar.appearance().barTintColor = UIColor(red:128/256, green:216/256, blue:208/256, alpha: 1)
    }
    @ObservedObject var viewModel = ListViewModel.shared
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color(red:128/256, green:216/256, blue:208/256))
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
                        EditButton()
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
                        NavigationLink(destination: ListView()) {
                            Image("home")
                                .renderingMode(.original)
                                .resizable()
                                .padding(40)
                                .frame(width: 120, height: 120)
                        }
                        Spacer()
                        Button(action: {
                            viewModel.displayAddView.toggle()
                        }) {
                            Image("setting")
                                .renderingMode(.original)
                                .resizable()
                                .padding(40)
                                .frame(width: 120, height: 120)
                        }
                    }
                    
                }
                // 追加画面
                .sheet(isPresented: $viewModel.displayAddView) {
                    AddView()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
