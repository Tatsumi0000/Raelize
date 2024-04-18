//
//  WordListFileRepositoryTests.swift
//
//  Created by Tatsumi0000 on 2024/04/18
//
//

import Combine
import Foundation
import Testing

@testable import RaelizeLogic

final class WordListFileRepositoryTests {

    private let repository: any WordListFileRepositoryType
    private var cancellables: Set<AnyCancellable> = []

    init() {
        self.repository = RepositoryProvider.shared.wordListFileRepository
    }

    deinit {

    }

    @Test
    func readFile() {
        self.repository.readFile(fileName: "a")
        self.repository.getWordList()
            .sink(receiveValue: { words in
                #expect(!words!.isEmpty)
            })
            .store(in: &cancellables)
    }

    @Test
    func resetFile() {
        self.repository.readFile(fileName: "a")
        self.repository.resetFile()
        self.repository.getWordList()
            .sink(receiveValue: { words in
                #expect(words == nil)
            })
            .store(in: &cancellables)
    }

}
