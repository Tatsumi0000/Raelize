// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import InputMethodKit

@objc(RaelizeIMKController)
public class RaelizeIMKController: IMKInputController {

  public override func inputText(_ string: String!, client sender: Any!) -> Bool {
    return true
  }

  /// Candidate selection has been moved.
  /// - Parameter candidateString: <#candidateString description#>
  public override func candidateSelectionChanged(_ candidateString: NSAttributedString!) {
    print("---candidateSelectionChanged---")
    print(candidateString)
  }

  /// Candidate selection has been selected.
  /// - Parameter candidateString: <#candidateString description#>
  public override func candidateSelected(_ candidateString: NSAttributedString!) {
    print("---candidateSelected---")
    print(candidateString)
  }

}
