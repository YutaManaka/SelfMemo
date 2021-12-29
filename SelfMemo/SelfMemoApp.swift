//
//  SelfMemoApp.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/28.
//

import SwiftUI

@main
struct SelfMemoApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
    // インスタンス化された AppModel のライフサイクルをアプリと同じにする
    @StateObject var appModel: AppModel = AppModel()
    var body: some Scene {
        WindowGroup {
            // 作成された AppModel の インスタンスと インスタンスプロパティ textLines を以降の UI (ContentView) に渡す
            ContentView(appModel: appModel, textLines: appModel.textLineList)
        }
    }
}
