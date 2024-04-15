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

    @Dependency(\.wordListFileUseCase)
    private var wordListFileUseCase

    /// UI state
    @ObservableState
    public struct State: Equatable {
        /// Raelize mode
        var raelizeState: RaelizeState
        /// Candinates list
        var candinates: [String] = []
        /// Typing word
        var inputWord: String = ""
        /// Current open file
        var fileName: String = ""
        /// Decision word
        var insertText: String = ""
        /// Selected word on candinates
        var selectedWord: String = ""
        /// Candinate event
        var candidateEvent: NSEvent? = nil
    }

    /// User action
    public enum Action: Equatable {
        /// Operation keys(Enter, Arrow and so on)
        case operationEventKey(NSEvent)
        /// Typing word
        case inputWord(String)
        /// Searched word
        case checkWord([String]?)
        /// Decision word
        case insertText(String)
        /// Selected word
        case selectedWord(String)
        /// Reset current state
        case resetState(RaelizeState)
        /// Only called by IMKInputController.handle method.
        /// Update RaelizeState
        case handleRaelizeState(NSEvent)
    }

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .operationEventKey(let event):
            let keyEvent = KeyEvent(keyCode: Int(event.keyCode))
            state.raelizeState = .operationMode
            switch keyEvent.eventName {
            case .enter:
                let text = state.candinates.isEmpty ? state.inputWord : state.selectedWord
                if text.isEmpty {
                    return .send(.resetState(.neutralMode))
                }
                return .run(operation: { send in
                    await send(.insertText(text))
                })
            case .upArrow, .downArrow, .tab:
                state.candidateEvent = event
                return .none
            case .backspace:
                state.inputWord.removeLast()
                let word = state.inputWord
                return .publisher({
                    wordListFileUseCase.searchWordList(word: word)
                        .map({ Action.checkWord($0) })
                })
            default:
                return .none
            }
        case .insertText(let text):
            state.raelizeState = .inputMode
            state.insertText = text
            NSLog("insertText is [\(state.insertText)].")
            return .run(operation: { send in
                await send(.resetState(.neutralMode))
            })
        case .inputWord(let word):
            state.raelizeState = .inputMode
            state.inputWord += word
            NSLog("word\(word)")
            NSLog("state.inputWord\(state.inputWord)")
            let fileName = wordListFileUseCase.convertWordToFileName(word: state.inputWord)
            if state.fileName != fileName {
                state.fileName = fileName
                NSLog("🛠️\(state.fileName)")
                wordListFileUseCase.readFile(fileName: state.fileName)
            }
            NSLog("🛠️\(state.inputWord)")
            let word = state.inputWord
            if word.isEmpty {
                return .run(operation: { send in
                    await send(.resetState(.neutralMode))
                })
            }
            return .publisher({
                wordListFileUseCase.searchWordList(word: word)
                    .map({ Action.checkWord($0) })
            })
        case .checkWord(let words):
            guard let words = words else {
                state.candinates = []
                return .none
            }
            state.candinates = words
            return .none
        case .selectedWord(let word):
            state.raelizeState = .operationMode
            state.selectedWord = word
            return .none
        case .resetState(let raelizeState):
            wordListFileUseCase.resetWordList()
            state = State(raelizeState: raelizeState)
            return .none
        case .handleRaelizeState(let event):
            let keyCode = KeyEvent(keyCode: Int(event.keyCode))
            if keyCode.eventName != .undifined {
                state.raelizeState = .operationMode
                return .send(.operationEventKey(event))
            }
            if let string = event.characters, isPrintable(string) {
                state.raelizeState = .inputMode
                return .run(operation: { send in
                    await send(.inputWord(string))
                })
            }
            return .none
        }
    }
}

extension RaelizeIMKReducer {
    func isPrintable(_ text: String) -> Bool {
        let printable = [
            CharacterSet.alphanumerics,
            CharacterSet.symbols,
            CharacterSet.punctuationCharacters,
        ]
        .reduce(CharacterSet(), { $0.union($1) })
        return !text.unicodeScalars.contains(where: { !printable.contains($0) })
    }
}
