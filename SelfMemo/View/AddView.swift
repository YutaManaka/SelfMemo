//
//  AddView.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/30.
//

import SwiftUI
import Foundation

struct AddView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = ListViewModel.shared
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("ToDo")) {
                    TextField("", text: $viewModel.text)
                }
            }
            .navigationTitle(viewModel.updatingTodo == nil ? "ToDoを追加" : "ToDoを更新")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // 追加
                        if (viewModel.updatingTodo == nil) {
                            viewModel.addTodo()
                        } else {
                        // 更新
                            viewModel.updateTodo()
                        }
                        
                        viewModel.displayAddView.toggle()
                    }) {
                        Text("完了")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                        viewModel.cancel()
                    }) {
                        Text("キャンセル")
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
