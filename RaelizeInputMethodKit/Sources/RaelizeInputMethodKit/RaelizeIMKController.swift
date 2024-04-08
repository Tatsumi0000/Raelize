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
            initialState: RaelizeIMKReducer.State(),
            reducer: { RaelizeIMKReducer() })

        super.init(server: server, delegate: delegate, client: inputClient)
        NSLog("🛠️setup")
        guard let client = inputClient as? IMKTextInput else {
            return
        }
        let notFound = NSRange(location: NSNotFound, length: NSNotFound)

        observe {
            if self.store.candinates.isEmpty {
                self.candidates.hide()
            } else {
                self.candidates.update()
                self.candidates.show()
            }
        }
        observe {
            client.insertText(self.store.insertText, replacementRange: notFound)
            //            self.store.send(.inputWord("")) reset word
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

        if let _ = event.specialKey {
            self.store.send(.operationEventKey(event))
            return false
        }
        if let text = event.characters, isPrintable(text) {
            self.store.send(.inputWord(text))
            return true
        }
        return false
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

    public override func deactivateServer(_ sender: Any) {
        self.candidates.hide()
    }

    public override func candidateSelectionChanged(_ candidateString: NSAttributedString!) {
        NSLog("🛠️candidateSelectionChanged: %@", "\(candidateString)")
    }

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
