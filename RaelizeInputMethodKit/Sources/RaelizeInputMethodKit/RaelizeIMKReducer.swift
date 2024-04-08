//
//  RaelizeIMKReducer.swift
//
//  Created by Tatsumi0000 on 2024/03/28
//
//

import AppKit
import Combine
import ComposableArchitecture
import Foundation
import RaelizeLogic

@Reducer
public struct RaelizeIMKReducer {

    private let provider = UseCaseProvider.shared.wordListFileUseCase

    /// UI state
    @ObservableState
    public struct State: Equatable {
        var candinates: [String] = []
        var inputWord: String = ""
        var fileName: String = ""
        var insertText: String = ""
        var candidateEvent: NSEvent? = nil
    }

    /// User action
    public enum Action {
        /// Operation keys(Enter, Arrow and so on)
        case operationEventKey(NSEvent)
        /// Typing word
        case inputWord(String)
        /// Searched word
        case checkWord([String]?)
        /// Selected word
        case insertText(String)
        /// Reset current state
        case resetState
    }

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .operationEventKey(let event):
            switch event.specialKey {
            case .enter, .upArrow, .downArrow, .tab:
                state.candidateEvent = event
                return .none
            case .backspace:
                state.inputWord.removeLast()
                let word = state.inputWord
                return .publisher({
                    provider.searchWordList(word: word)
                        .map({ Action.checkWord($0) })
                })
            default:
                return .none
            }
        case .insertText(let text):
            state.insertText = text
            return .run(operation: { send in
                await send(.resetState)
            })
        case .inputWord(let word):
            state.inputWord += word
            NSLog("word\(word)")
            NSLog("state.inputWord\(state.inputWord)")
            let fileName = provider.convertWordToFileName(word: state.inputWord)
            if state.fileName != fileName {
                state.fileName = fileName
                NSLog("🛠️\(state.fileName)")
                provider.readFile(fileName: state.fileName)
            }
            NSLog("🛠️\(state.inputWord)")
            let word = state.inputWord
            return .publisher({
                provider.searchWordList(word: word)
                    .map({ Action.checkWord($0) })
            })
        case .checkWord(let words):
            guard let words = words else {
                state.candinates = []
                return .none
            }
            state.candinates = words
            return .none
        case .resetState:
            state = State()
            return .none
        }

    }
}
