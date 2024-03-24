//
//  RepositoryProvider.swift
//
//  Created by Tatsumi0000 on 2024/03/24
//
//

import Foundation

protocol RepositoryProviderType {
    var wordListFileRepository: WordListFileRepositoryType { get }
}

class RepositoryProvider: RepositoryProviderType {

    private init() {}
    static let shared: RepositoryProviderType = RepositoryProvider()

    var wordListFileRepository: WordListFileRepositoryType = WordListFileRepository()
}
