//
//  RaelizeStateTests.swift
//
//  Created by Tatsumi0000 on 2024/04/13
//
//

import Foundation
import Testing

@testable import RaelizeInputMethodKit

@Suite("Model/RaelizeState.swift test")
struct RaelizeStateTests {

    @Test
    func raelizeStateCount() {
        let expected = 3
        let numberOfCases = RaelizeState.allCases.count
        #expect(numberOfCases == expected)
    }
}
