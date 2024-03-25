//
//  WordListFileUseCase.swift
//
//  Created by Tatsumi0000 on 2024/03/24
//
//

import Combine
import Foundation

public protocol WordListFileUseCaseType {
    var currentWordList: CurrentValueSubject<[String]?, Never> { get }
    func getWordList() -> [String]?
    func resetWordList()
    func searchWordList(word: String)
}

final public class WordListFileUseCase: WordListFileUseCaseType {

    /// Want to display word-list
    public let currentWordList = CurrentValueSubject<[String]?, Never>(nil)
    /// Shared repository instance
    private let provider: RepositoryProviderType
    /// Number of items to candidate
    public let candidatesSize: Int
    private var cancellables: Set<AnyCancellable> = []

    init(provider: RepositoryProviderType, candidatesSize: Int = 20) {
        self.provider = provider
        self.candidatesSize = candidatesSize
    }

    /// Get current word-list
    /// - Returns: word-list
    public func getWordList() -> [String]? {
        return self.currentWordList.value
    }

    /// Delete word-list to display
    public func resetWordList() {
        self.currentWordList.value = nil
        self.provider.wordListFileRepository.resetFile()
    }

    public func searchWordList(word: String) {
        self.provider.wordListFileRepository.getWordList()
            .compactMap({
                if $0 == nil { self.currentWordList.send(nil) }
                return $0  // cast non-nil
            })
            .map({ (dicts: [String]) -> [String]? in
                let candinates = self.binarySearch(
                    word: word, candidatesSize: self.candidatesSize, wordList: dicts)
                return candinates
            })
            .sink(receiveValue: { self.currentWordList.send($0) })
            .store(in: &cancellables)
    }
}

extension WordListFileUseCaseType {

    /// Binary seach
    /// - Parameters:
    ///   - word: Search word
    ///   - candidatesSize: Candinates size
    ///   - wordList: Search target Array
    /// - Returns: Array from the point containing the prefix specified by word to the point specified by candidatesSize
    func binarySearch(word: String, candidatesSize: Int, wordList: [String]) -> [String]? {
        var left = 0
        var right = wordList.count - 1
        while left <= right {
            let middle = (left + right) / 2

            if wordList[middle].hasPrefix(word) {
                var lastIndex = middle + candidatesSize
                lastIndex = wordList.count - 1 > lastIndex ? lastIndex : middle  // check out of range
                return Array(wordList[middle...lastIndex])
            } else if wordList[middle] < word {
                left = middle + 1
            } else {
                right = middle - 1
            }
        }
        return nil

    }
}
