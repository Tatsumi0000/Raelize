import Foundation
//
//  File.swift
//
//  Created by Tatsumi0000 on 2024/04/13
//
//
import Testing

@testable import RaelizeInputMethodKit

@Suite("Model/KeyEvent.swift test")
struct KeyEventTests {
    typealias TestCase = (
        keyCode: Int, expected: KeyEvent.EventName, sourceLocation: SourceLocation
    )
    static let testCases: [TestCase] = [
        (keyCode: 2, expected: .undifined, sourceLocation: SourceLocation()),
        (keyCode: 36, expected: .enter, sourceLocation: SourceLocation()),
        (keyCode: 51, expected: .backspace, sourceLocation: SourceLocation()),
        (keyCode: 126, expected: .upArrow, sourceLocation: SourceLocation()),
        (keyCode: 125, expected: .downArrow, sourceLocation: SourceLocation()),
        (keyCode: 48, expected: .tab, sourceLocation: SourceLocation()),
        (keyCode: 111, expected: .undifined, sourceLocation: SourceLocation()),
    ]
    @Test(arguments: Self.testCases)
    func convertIntToEventName(testCase: TestCase) {
        let keyEvent = KeyEvent(keyCode: testCase.keyCode).eventName
        #expect(keyEvent == testCase.expected, sourceLocation: testCase.sourceLocation)
    }
}
