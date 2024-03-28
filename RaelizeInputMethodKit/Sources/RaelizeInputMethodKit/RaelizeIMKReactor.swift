//
//  RaelizeIMKReactor.swift
//
//  Created by Tatsumi0000 on 2024/03/28
//  
//

import Foundation
import AppKit
import Combine

public final class RaelizeIMKReactor {
    
    /// User action
    enum Action {
        /// Operation keys(Enter, Arrow and so on)
        case operationEventKey(NSEvent.SpecialKey)
        /// Type word
        case inputWord(String?)
    }
    
    /// Change State
    enum Mutation {
        case setIsInputing(Bool)
        case setIsCandidatesShowing(Bool)
        case setCandinates([String]?)
        case setInputWord(String?)
      }
    
    /// UI state
    struct State {
        var isInputing: Bool = false
        var isCandidatesShowing: Bool = false
        var candinates: [String]? = nil
        var inputWord: String? = nil
    }
    let initialState = State()
    
    /// TODO: Delete return value Optional
    func mutate(action: Action) -> AnyPublisher<Mutation, Never>? {
        switch action {
        case .operationEventKey(.enter):
            return nil
        case .operationEventKey(.upArrow):
            return nil
        case .operationEventKey(.downArrow):
            return nil
        case .inputWord(let word):
            print(word ?? "word is nil.")
            return nil
        default:
            return nil
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setIsInputing(let isInputing):
            state.isInputing = isInputing
        case .setIsCandidatesShowing(let isCandidatesShowing):
            state.isCandidatesShowing = isCandidatesShowing
        case .setCandinates(let candinates):
            state.candinates = candinates
        case .setInputWord(let inputWord):
            state.inputWord = inputWord
        }
        return state
    }
    
}
