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
                    $0.wordListFileUseCase = WordListFileUseCaseMock()
                })
            await store.send(.resetState(.neutralMode)) {
                $0.raelizeState = .neutralMode
            }
        }

        @Suite("RaelizeInputMethodKit.Action.operationEventKey Tests")
        final class OperationEventKey {
            @Test @MainActor
            func enterKeyAndCandinatesEmpty() async {
                let store = TestStore(
                    initialState: RaelizeIMKReducer.State(raelizeState: .neutralMode),
                    reducer: { RaelizeIMKReducer() },
                    withDependencies: {
                        $0.wordListFileUseCase = WordListFileUseCaseMock()
                    })
                let enterKeyEvent = NSEvent.keyEvent(
                    with: .keyDown, location: NSPoint(), modifierFlags: NSEvent.ModifierFlags(),
                    timestamp: 0, windowNumber: 0, context: nil, characters: "",
                    charactersIgnoringModifiers: "", isARepeat: false, keyCode: 36)!
                await store.send(.operationEventKey(enterKeyEvent)) {
                    $0.raelizeState = .operationMode
                }
                await store.receive(.resetState(.neutralMode)) {
                    $0.raelizeState = .neutralMode
                }
            }

            @Test @MainActor
            func enterKeyAndInputWord() async {
                let store = TestStore(
                    initialState: RaelizeIMKReducer.State(
                        raelizeState: .neutralMode, candinates: ["a0", "a1"], inputWord: "a",
                        selectedWord: "a0"),
                    reducer: { RaelizeIMKReducer() },
                    withDependencies: {
                        $0.wordListFileUseCase = WordListFileUseCaseMock()
                    })
                let enterKeyEvent = NSEvent.keyEvent(
                    with: .keyDown, location: NSPoint(), modifierFlags: NSEvent.ModifierFlags(),
                    timestamp: 0, windowNumber: 0, context: nil, characters: "",
                    charactersIgnoringModifiers: "", isARepeat: false, keyCode: 36)!
                await store.send(.operationEventKey(enterKeyEvent)) {
                    $0.raelizeState = .operationMode
                }
                await store.receive(.insertText("a0")) {
                    $0.insertText = "a0"
                    $0.raelizeState = .inputMode
                }
                await store.receive(.resetState(.neutralMode)) {
                    $0 = RaelizeIMKReducer.State(raelizeState: .neutralMode)
                }
            }
        }
    }
}
