//
//  SelfMemoApp.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2021/12/28.
//

import SwiftUI
import Intents

@main
struct RealmTodoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    class AppDelegate: UIResponder, UIApplicationDelegate {
        func application(_ application: UIApplication, handlerFor intent: INIntent) -> Any? {

            switch intent {
                case is AddTodoFromVoiceIntent:
                    return AddTodoFromVoiceIntentHandler()
                default:
                    return nil
            }
        }
    }
}
