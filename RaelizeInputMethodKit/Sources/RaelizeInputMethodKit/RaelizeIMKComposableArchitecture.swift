//
//  RaelizeIMKReducer.swift
//
//  Created by Tatsumi0000 on 2024/03/28
//  
//

import Foundation
import AppKit
import ComposableArchitecture

@Reducer
public struct RaelizeIMKReducer {
    
    /// UI state
    @ObservableState
    struct State: Equatable {
        var isCandidatesShowing: Bool = false
        var candinates: [String]? = nil
        var inputWord: String? = nil
        var selectedWord: String? = nil
    }
    
    /// User action
    enum Action {
        /// Operation keys(Enter, Arrow and so on)
        case operationEventKey(NSEvent.SpecialKey)
        /// Typing word
        case inputWord(String?)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .operationEventKey(.enter):
            return .none
        case .operationEventKey(.upArrow):
            return .none
        case .operationEventKey(.downArrow):
            return .none
        case .inputWord(let word):
            print(word ?? "word is nil.")
            return .none
        default:
            return .none
        }
    }
}
