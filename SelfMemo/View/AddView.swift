//
//  AddView.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/30.
//

import SwiftUI
import Foundation

struct AddView: View {
//    init() {
//        // TextEditorの背景色を設定するため
//        UITextView.appearance().backgroundColor = .clear
//    }
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = ListViewModel.shared
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color(red:128/256, green:216/256, blue:208/256))
                        .frame(maxWidth: .infinity, maxHeight: 8)
                List {
                    Section(header: Text("タスク名")) {
                        TextField("タスク名を記入してください", text: $viewModel.text)
                            .overlay(
                                RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                                .stroke(Color.gray, lineWidth: 1.0)
                                .padding(-8.0)
                            )
                    }
                    .background(Color.white)
                }
            }
            //ツールバー
            .toolbar {
                // ナビゲーションバー左
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                        viewModel.cancel()
                    }) {
                        Text("キャンセル")
                    }
                }
                // ナビゲーションバー右
                ToolbarItem(placement: .navigationBarTrailing) {
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
            }
            // ナビゲーションバータイトル
            .navigationBarTitle(
                viewModel.updatingTodo == nil ? "タスクを追加" : "タスクを更新",
                displayMode: .inline
            )
        }
    }
}

private struct CustomStyle: ViewModifier {
    public func body(content: Content) -> some View {
        return content
            .padding()
            .foregroundColor(.green)
            .background(Color.yellow)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
