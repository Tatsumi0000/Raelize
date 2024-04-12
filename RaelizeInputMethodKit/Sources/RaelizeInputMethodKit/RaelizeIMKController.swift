// The Swift Programming Language
// https://docs.swift.org/swift-book

import ComposableArchitecture
import Foundation
import InputMethodKit

@objc(RaelizeIMKController)
public class RaelizeIMKController: IMKInputController {

    private let candidates: IMKCandidates
    private let store: StoreOf<RaelizeIMKReducer>

    public override init!(server: IMKServer!, delegate: Any!, client inputClient: Any!) {
        self.candidates = IMKCandidates(
            server: server, panelType: kIMKSingleColumnScrollingCandidatePanel)
        self.store = Store(
            initialState: RaelizeIMKReducer.State(raelizeState: .inputMode),
            reducer: { RaelizeIMKReducer() })

        super.init(server: server, delegate: delegate, client: inputClient)
        NSLog("🛠️setup🛠️")
        guard let client = inputClient as? IMKTextInput else {
            return
        }
        let notFound = NSRange(location: NSNotFound, length: NSNotFound)

        observe {
            if self.store.candinates.isEmpty || self.store.inputWord.isEmpty {
                self.candidates.hide()
            } else {
                self.candidates.update()
                self.candidates.show()
            }
        }
        observe {
            client.insertText(
                self.store.insertText,
                replacementRange: NSRange(location: self.store.insertText.count, length: 0))
        }
        observe {
            client.setMarkedText(
                self.store.inputWord,
                selectionRange: NSRange(location: self.store.inputWord.count, length: 0),
                replacementRange: notFound)
        }
        observe {
            if let candidateEvent = self.store.candidateEvent {
                self.candidates.interpretKeyEvents([candidateEvent])
            }
        }
    }

    public override func handle(_ event: NSEvent!, client sender: Any!) -> Bool {
        NSLog("🛠️handle")
        guard let event = event else { return false }

        self.store.send(.handleRaelizeState(event))

        switch self.store.raelizeState {
        case .neutralMode:
            return false
        case .inputMode:
            return true
        case .operationMode:
            return true
        }
    }

    public override func candidates(_ sender: Any!) -> [Any]! {
        NSLog("---candidates---")
        NSLog("🛠️%@", self.store.candinates)
        return self.store.candinates
    }

    public override func candidateSelected(_ candidateString: NSAttributedString!) {
        NSLog("---candidateSelected---")
        NSLog("🛠️\(candidateString.string)")
        self.store.send(.insertText(candidateString.string))
    }

    public override func candidateSelectionChanged(_ candidateString: NSAttributedString!) {
        guard let candidateString = candidateString else { return }

        NSLog("🛠️candidateSelectionChanged: %@", "\(candidateString)")
        self.store.send(.selectedWord(candidateString.string))
    }

    public override func deactivateServer(_ sender: Any) {
        self.candidates.hide()
        self.store.send(.resetState(.neutralMode))
    }
}
