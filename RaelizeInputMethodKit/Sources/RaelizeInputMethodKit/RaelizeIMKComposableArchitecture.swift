//
//  ComposableArchitecture.swift
//
//  Created by Tatsumi0000 on 2024/03/28
//  
//

import Foundation
import AppKit
import Combine

public final class RaelizeIMKComposableArchitecture {
    
    /// UI state
    struct State: Sendable {
        var isCandidatesShowing: Bool = false
        var candinates: [String]? = nil
        var inputWord: String? = nil
        var selectedWord: String? = nil
    }
    
    /// User action
    enum Action: Sendable {
        /// Operation keys(Enter, Arrow and so on)
        case operationEventKey(NSEvent.SpecialKey)
        /// Typing word
        case inputWord(String?)
    }
    
        
    /// TODO: Delete return value Optional
//    func mutate(action: Action) -> AnyPublisher<Mutation, Never>? {
//        switch action {
//        case .operationEventKey(.enter):
//            let step: AnyPublisher<Mutation, Never> = Empty()
//                .eraseToAnyPublisher()
//            return nil
//        case .operationEventKey(.upArrow):
//            return nil
//        case .operationEventKey(.downArrow):
//            return nil
//        case .inputWord(let word):
//            print(word ?? "word is nil.")
//            return nil
//        default:
//            return nil
//        }
//    }
//    
//    func reduce(state: State, mutation: Mutation) -> State {
//        var state = state
//        switch mutation {
//        case .setIsCandidatesShowing(let isCandidatesShowing):
//            state.isCandidatesShowing = isCandidatesShowing
//        case .setCandinates(let candinates):
//            state.candinates = candinates
//        case .setInputWord(let inputWord):
//            state.inputWord = inputWord
//        case .setSlectedWord(let slectedWord):
//            state.selectedWord = slectedWord
//        }
//        return state
//    }
    
}
