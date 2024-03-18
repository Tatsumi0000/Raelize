// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import InputMethodKit

@objc(RaelizeIMKController)
public class RaelizeIMKController: IMKInputController {
    
    private let candidates: IMKCandidates
    
    public override init!(server: IMKServer!, delegate: Any!, client inputClient: Any!) {
        self.candidates = IMKCandidates(server: server, panelType: kIMKSingleColumnScrollingCandidatePanel)
        super.init(server: server, delegate: delegate, client: inputClient)
    }

    public override func inputText(_ string: String!, client sender: Any!) -> Bool {
        NSLog(string)
        guard let client = sender as? IMKTextInput else {
            return false
        }
        
        self.candidates.update()
        self.candidates.show()
    
        client.insertText(string, replacementRange: NSRange(location: NSNotFound, length: NSNotFound))
        return true
    }
    
    public override func candidates(_ sender: Any!) -> [Any]! {
          return ["TEST0", "TEST1", "TEST2"]
    }

}
