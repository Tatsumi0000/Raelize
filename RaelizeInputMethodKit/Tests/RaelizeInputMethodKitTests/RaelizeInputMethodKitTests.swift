//
//  RaelizeInputMethodKitTests.swift
//
//  Created by Tatsumi0000 on 2024/04/04
//
//

import AppKit
import ComposableArchitecture
import RaelizeLogic
import Testing

@testable import RaelizeInputMethodKit

struct RaelizeInputMethodKitTests {

    private let example = true

    @Suite("RaelizeInputMethodKit.Action Tests")
    final class Action {

        @Test @MainActor
        func resetState() async {
            let store = TestStore(
                initialState: RaelizeIMKReducer.State(raelizeState: .inputMode),
                reducer: { RaelizeIMKReducer() },
                withDependencies: {
                    $0.wordListFileUseCase = UseCaseProvider.shared.wordListFileUseCase
                })
            await store.send(.resetState(.neutralMode)) {
                $0.raelizeState = .neutralMode
            }
        }
        //
        //        @Test
        //        func operationEventKey() async {
        //            let store = TestStore(initialState: RaelizeIMKReducer.State(raelizeState: .neutralMode) , reducer: { RaelizeIMKReducer() }, withDependencies: { $0.wordListFileUseCase.resetWordList() })
        //            var currentState = RaelizeIMKReducer.State(raelizeState: .neutralMode)
        //            var enterKeyEvent = NSEvent.keyEvent(with: .keyDown, location: NSPoint(), modifierFlags: NSEvent.ModifierFlags(), timestamp: 0, windowNumber: 0, context: nil, characters: "", charactersIgnoringModifiers: "", isARepeat: false, keyCode: 36)!
        //
        //        }
    }
}
