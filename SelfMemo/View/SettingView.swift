//
//  ListView.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/29.
//

import SwiftUI
import MessageUI

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
                    Link("プライバシーポリシー",
                         destination: URL(string: "https://github.com/YutaManaka/SelfMemo")!
                    )
                    Button(action: {
                        viewModel.displayMailView.toggle()
                    }) {
                        Text("お問合せ")
                    }
                    .disabled(!MFMailComposeViewController.canSendMail())
                        .listRowSeparatorTint(.black)
                }
            }
            // ツールバー
            .toolbar {
                // ナビゲーションバー左
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.displaySettingView.toggle()
                        viewModel.cancel()
                    }) {
                        Text("戻る")
                    }
                }
            }
            // ナビゲーションバータイトル
            .navigationBarTitle(
                "設定",
                displayMode: .inline
            )
            // メール画面
            .sheet(isPresented: $viewModel.displayMailView) {
                MailView(displayed: $viewModel.displayMailView)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
