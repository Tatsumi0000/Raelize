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
        var isCandidatesShowing: Bool = false
        var candinates: [String] = []
        var inputWord: String? = nil
        var selectedWord: String? = nil
    }

    /// User action
    public enum Action {
        /// Operation keys(Enter, Arrow and so on)
        case operationEventKey(NSEvent.SpecialKey)
        /// Typing word
        case inputWord(String?)
        /// Searched word
        case checkWord([String]?)
    }

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .operationEventKey(.enter):
            return .none
        case .operationEventKey(.upArrow):
            return .none
        case .operationEventKey(.downArrow):
            return .none
        case .inputWord(let word):
            print(word ?? "word is nil.")
            state.inputWord = word
            return .publisher({
                provider.searchWordList(word: "")
                    .map({ Action.checkWord($0) })
            })
        case .checkWord(let words):
            guard let words = words else {
                state.isCandidatesShowing = false
                state.candinates = []
                state.selectedWord = nil
                return .none
            }
            state.candinates = words
            return .none
        default:
            return .none
        }
    }
}
