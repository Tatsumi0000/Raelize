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

            @Test @MainActor
            func upArrowKey() async {
                let store = TestStore(
                    initialState: RaelizeIMKReducer.State(raelizeState: .neutralMode),
                    reducer: { RaelizeIMKReducer() },
                    withDependencies: {
                        $0.wordListFileUseCase = WordListFileUseCaseMock()
                    })
                let upArrowKeyEvent = NSEvent.keyEvent(
                    with: .keyDown, location: NSPoint(), modifierFlags: NSEvent.ModifierFlags(),
                    timestamp: 0, windowNumber: 0, context: nil, characters: "",
                    charactersIgnoringModifiers: "", isARepeat: false, keyCode: 126)!
                await store.send(.operationEventKey(upArrowKeyEvent)) {
                    $0.candidateEvent = upArrowKeyEvent
                    $0.raelizeState = .operationMode
                }
            }

            @Test @MainActor
            func backSpaceKey() async {
                let store = TestStore(
                    initialState: RaelizeIMKReducer.State(
                        raelizeState: .neutralMode, candinates: ["test0", "test1"],
                        inputWord: "test",
                        selectedWord: "test0"),
                    reducer: { RaelizeIMKReducer() },
                    withDependencies: {
                        $0.wordListFileUseCase = WordListFileUseCaseMock()
                    })
                let backSpaceKeyEvent = NSEvent.keyEvent(
                    with: .keyDown, location: NSPoint(), modifierFlags: NSEvent.ModifierFlags(),
                    timestamp: 0, windowNumber: 0, context: nil, characters: "",
                    charactersIgnoringModifiers: "", isARepeat: false, keyCode: 51)!
                let words = ["test0", "test1", "test2", "test3", "test4"]
                await store.send(.operationEventKey(backSpaceKeyEvent)) {
                    $0.raelizeState = .operationMode
                    $0.inputWord = "tes"
                }
                await store.receive(.candinates(words)) {
                    $0.candinates = words
                }
            }

            @Test @MainActor
            func undifinedKey() async {
                let store = TestStore(
                    initialState: RaelizeIMKReducer.State(raelizeState: .neutralMode),
                    reducer: { RaelizeIMKReducer() },
                    withDependencies: {
                        $0.wordListFileUseCase = WordListFileUseCaseMock()
                    })
                let undifinedKeyEvent = NSEvent.keyEvent(
                    with: .keyDown, location: NSPoint(), modifierFlags: NSEvent.ModifierFlags(),
                    timestamp: 0, windowNumber: 0, context: nil, characters: "",
                    charactersIgnoringModifiers: "", isARepeat: false, keyCode: 12345)!
                await store.send(.operationEventKey(undifinedKeyEvent)) {
                    $0.raelizeState = .operationMode
                }
            }
        }

        @Test @MainActor
        func insertText() async {
            let store = TestStore(
                initialState: RaelizeIMKReducer.State(raelizeState: .neutralMode),
                reducer: { RaelizeIMKReducer() },
                withDependencies: {
                    $0.wordListFileUseCase = WordListFileUseCaseMock()
                })
            await store.send(.insertText("hoge")) {
                $0.raelizeState = .inputMode
                $0.insertText = "hoge"
            }
            await store.receive(.resetState(.neutralMode)) {
                $0 = RaelizeIMKReducer.State(raelizeState: .neutralMode)
            }
        }

        @Test @MainActor
        func candinates() async {
            let store = TestStore(
                initialState: RaelizeIMKReducer.State(raelizeState: .neutralMode),
                reducer: { RaelizeIMKReducer() },
                withDependencies: {
                    $0.wordListFileUseCase = WordListFileUseCaseMock()
                })
            let words = ["test0", "test1", "test2", "test3", "test4"]
            await store.send(.candinates(words)) {
                $0.candinates = words
            }
        }

        @Test @MainActor
        func candinatesNil() async {
            let store = TestStore(
                initialState: RaelizeIMKReducer.State(
                    raelizeState: .neutralMode, candinates: ["test"]),
                reducer: { RaelizeIMKReducer() },
                withDependencies: {
                    $0.wordListFileUseCase = WordListFileUseCaseMock()
                })
            await store.send(.candinates(nil)) {
                $0.candinates = []
            }
        }

        @Test @MainActor
        func selectedWord() async {
            let store = TestStore(
                initialState: RaelizeIMKReducer.State(raelizeState: .neutralMode),
                reducer: { RaelizeIMKReducer() },
                withDependencies: {
                    $0.wordListFileUseCase = WordListFileUseCaseMock()
                })
            await store.send(.selectedWord("test")) {
                $0.raelizeState = .operationMode
                $0.selectedWord = "test"
            }
        }

        final class HandleRaelizeState {
            @Test @MainActor
            func backSpaceKey() async {
                let store = TestStore(
                    initialState: RaelizeIMKReducer.State(
                        raelizeState: .neutralMode),
                    reducer: { RaelizeIMKReducer() },
                    withDependencies: {
                        $0.wordListFileUseCase = WordListFileUseCaseMock()
                    })
                let undifinedKeyEvent = NSEvent.keyEvent(
                    with: .keyDown, location: NSPoint(), modifierFlags: NSEvent.ModifierFlags(),
                    timestamp: 0, windowNumber: 0, context: nil, characters: "test",
                    charactersIgnoringModifiers: "", isARepeat: false, keyCode: 17)!
                await store.send(.handleRaelizeState(undifinedKeyEvent)) {
                    $0.raelizeState = .inputMode
                }
                await store.receive(.inputWord("test")) {
                    $0.inputWord = "test"
                    $0.fileName = "a"
                }
                let words = ["test0", "test1", "test2", "test3", "test4"]
                await store.receive(.candinates(words)) {
                    $0.candinates = words
                }
            }
        }
    }
}
