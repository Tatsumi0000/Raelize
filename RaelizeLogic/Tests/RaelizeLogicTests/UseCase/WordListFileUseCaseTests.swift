//
//  WordListFileUseCaseTests.swift
//
//  Created by Tatsumi0000 on 2024/04/04
//
//

import Testing

@testable import RaelizeLogic

struct WordListFileUseCaseTests {

    @Suite(.tags("convertWordToFileName method Test"))
    struct ConvertWordToFileName {
        struct WordToFileName {
            let word: String
            let fileName: String
        }
        typealias TestCase = (word: String, fileName: String, sourceLocation: SourceLocation)
        static let testCases: [TestCase] = [
            (word: "apple", fileName: "a", sourceLocation: SourceLocation()),
            (word: "Buzy", fileName: "b", sourceLocation: SourceLocation()),
            (word: "zz", fileName: "z", sourceLocation: SourceLocation()),
            (word: "001CB", fileName: "0-9", sourceLocation: SourceLocation()),
            (word: "999scd", fileName: "0-9", sourceLocation: SourceLocation()),
            (word: "&&&", fileName: "symbols", sourceLocation: SourceLocation()),
            (word: "**ac0CC", fileName: "symbols", sourceLocation: SourceLocation()),
        ]
        @Test(arguments: Self.testCases)
        func convertWordToFileName(testCase: TestCase) {
            let wordToFileName = WordToFileName(word: testCase.word, fileName: testCase.fileName)
            let provider = UseCaseProvider.shared.wordListFileUseCase
            #expect(
                wordToFileName.fileName
                    == provider.convertWordToFileName(
                        word: wordToFileName.word), sourceLocation: testCase.sourceLocation)
        }
    }
}
