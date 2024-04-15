//
//  WordListFileUseCaseMock.swift
//
//  Created by Tatsumi0000 on 2024/04/15
//
//

import Combine
import Foundation
import RaelizeLogic

/// Using test.
///
/// TestStore's withDependencies
/// Pass to withDependencies of TestStore.
/// For example,
/// ```swift
/// let store = TestStore(
///     initialState: RaelizeIMKReducer.State(raelizeState: .inputMode),
///     reducer: { RaelizeIMKReducer() },
///     // here!
///     withDependencies: {
///         $0.wordListFileUseCase = WordListFileUseCaseMock()
///     })
/// ```
final class WordListFileUseCaseMock: WordListFileUseCaseType {

    func readFile(fileName: String) {}

    func resetWordList() {}

    func searchWordList(word: String) -> AnyPublisher<[String]?, Never> {
        let strings = ["test0", "test1", "test2", "test3", "test4"]
        return Future { result in
            result(.success(strings))
        }
        .eraseToAnyPublisher()
    }

    func convertWordToFileName(word: String) -> String {
        return "a"
    }
}
