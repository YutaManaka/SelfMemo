//
//  ListView.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/29.
//

import SwiftUI

struct SettingView: View {
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
                    Text("アプリをレビューする")
                    Text("プライバシーポリシー")
                    Text("お問合せ")
                        .listRowSeparatorTint(.black)
                }
            }
            // ツールバー
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.displaySettingView.toggle()
                        viewModel.cancel()
                    }) {
                        Text("戻る")
                    }
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}