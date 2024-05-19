//
//  WordListFileUseCase.swift
//
//  Created by Tatsumi0000 on 2024/03/24
//
//

import Combine
import Foundation

public protocol WordListFileUseCaseType {
    func readFile(fileName: String)
    /// Delete word-list to display
    func resetWordList()
    /// Preparing data for search
    func searchWordList(word: String) -> AnyPublisher<[String]?, Never>
    /// Convert Word to FileName
    func convertWordToFileName(word: String) -> String
}

final public class WordListFileUseCase: WordListFileUseCaseType {

    /// Shared repository instance
    private let provider: RepositoryProviderType
    /// Number of items to candidate
    public let candidatesSize: Int
    private var cancellables: Set<AnyCancellable> = []

    init(provider: RepositoryProviderType, candidatesSize: Int = 20) {
        self.provider = provider
        self.candidatesSize = candidatesSize
    }

    public func readFile(fileName: String) {
        self.provider.wordListFileRepository.readFile(fileName: fileName)
    }

    public func resetWordList() {
        self.provider.wordListFileRepository.resetFile()
    }

    public func searchWordList(word: String) -> AnyPublisher<[String]?, Never> {
        let word = word.lowercased()
        return self.provider.wordListFileRepository.getWordList()
            .compactMap({
                if $0 == nil { return nil }
                return $0  // cast non-nil
            })
            .map({ (dicts: [String]) -> [String]? in
                let candinates = self.binarySearch(
                    word: word, candidatesSize: self.candidatesSize, wordList: dicts)
                return candinates
            })
            .eraseToAnyPublisher()
    }

    public func convertWordToFileName(word: String) -> String {
        let word = word.lowercased()
        let startIndex = word.startIndex
        let startWord = word[startIndex]
        let fileName: String
        switch startWord {
        case "a"..."z":
            fileName = String(startWord)
        case "0"..."9":
            fileName = "0-9"
        default:
            fileName = "symbols"
        }
        return fileName
    }
}

extension WordListFileUseCaseType {

    /// Binary search of wordList
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

            if wordList[middle].lowercased().hasPrefix(word) {
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
