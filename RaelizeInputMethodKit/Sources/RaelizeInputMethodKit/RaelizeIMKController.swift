// The Swift Programming Language
// https://docs.swift.org/swift-book

import ComposableArchitecture
import Foundation
import InputMethodKit

@objc(RaelizeIMKController)
public class RaelizeIMKController: IMKInputController {

    private let candidates: IMKCandidates
    private let store: StoreOf<RaelizeIMKReducer> = Store(
        initialState: RaelizeIMKReducer.State(),
        reducer: { RaelizeIMKReducer() })

    public override init!(server: IMKServer!, delegate: Any!, client inputClient: Any!) {
        self.candidates = IMKCandidates(
            server: server, panelType: kIMKSingleColumnScrollingCandidatePanel)
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
            client.insertText(self.store.insertText, replacementRange: notFound)
            client.setMarkedText(
                self.store.inputWord, selectionRange: notFound, replacementRange: notFound)
        }
    }

    public override func handle(_ event: NSEvent!, client sender: Any!) -> Bool {
        NSLog("🛠️handle")
        if let specialKey = event.specialKey {
            self.store.send(.operationEventKey(specialKey))
            return false
        }
        if let text = event.characters, isPrintable(text) {
            self.store.send(.inputWord(text))
            NSLog("🛠️--if let--")
            NSLog("🛠️\(text)")
            return true
        }
        return true
    }

    public override func candidates(_ sender: Any!) -> [Any]! {
        NSLog("---candidates---")
        NSLog("🛠️%@", self.store.candinates)
        return self.store.candinates
    }

    public override func candidateSelected(_ candidateString: NSAttributedString!) {
        NSLog("---candidateSelected---")
        NSLog("🛠️\(candidateString.string)")
        self.store.send(.inputWord(candidateString.string))
    }

    public override func deactivateServer(_ sender: Any) {
        self.candidates.hide()
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
