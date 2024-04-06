//
//  WordListFileRepository.swift
//
//  Created by Tatsumi0000 on 2024/03/24
//
//

import Combine
import Foundation

protocol WordListFileRepositoryType {
    /// Read file. And, set word-list to wordListInFile.
    /// - Parameter fileName: File name
    func readFile(fileName: String)
    /// Get read file content
    func getWordList() -> AnyPublisher<[String]?, Never>
    /// Reset current file content.
    func resetFile()
}

final class WordListFileRepository: WordListFileRepositoryType {
    /// Current opened file content.
    private let wordListInFile = CurrentValueSubject<[String]?, Never>(nil)

    func readFile(fileName: String) {
        guard
            let fileUrl = Bundle.module.url(
                forResource: "Resources/dicts/" + fileName, withExtension: "tsv"),
            let data = try? String(contentsOf: fileUrl)
        else {
            NSLog("🛠️self.wordListInFile.send")
            self.wordListInFile.send(nil)
            return
        }
        let splittedData = data.components(separatedBy: .newlines).filter({ !$0.isEmpty })
        NSLog("🛠️\(splittedData.first)")
        self.wordListInFile.send(splittedData)
    }

    func getWordList() -> AnyPublisher<[String]?, Never> {
        return Future { result in
            result(.success(self.wordListInFile.value))
        }
        .eraseToAnyPublisher()
    }

    func resetFile() {
        self.wordListInFile.send(nil)
    }
}
