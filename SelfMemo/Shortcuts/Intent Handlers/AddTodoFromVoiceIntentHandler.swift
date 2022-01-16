//
//  File.swift
//  SelfMemo
//
//  Created by 勇太_物販 on 2022/01/16.
//

import Foundation
import Intents
import SwiftUI

class AddTodoFromVoiceIntentHandler: NSObject, AddTodoFromVoiceIntentHandling {
    @ObservedObject var viewModel = ListViewModel.shared
    func resolveText(for intent: AddTodoFromVoiceIntent, with completion: @escaping (AddTodoFromVoiceTextResolutionResult) -> Void) {
        if let text = intent.text, !text.isEmpty {
            completion(AddTodoFromVoiceTextResolutionResult.success(with: text))
        } else {
            completion(AddTodoFromVoiceTextResolutionResult.unsupported(forReason: .noText))
        }
    }
    func handle(intent: AddTodoFromVoiceIntent, completion: @escaping (AddTodoFromVoiceIntentResponse) -> Void) {
        if let inputText = intent.text {
            viewModel.text = inputText
            viewModel.addTodo()
            completion(AddTodoFromVoiceIntentResponse.success(result: inputText))
        } else {
            completion(AddTodoFromVoiceIntentResponse.failure(error: "The entered text was invalid"))
        }
    }
}
