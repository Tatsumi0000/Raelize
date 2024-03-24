//
//  WordListFileUseCase.swift
//
//  Created by Tatsumi0000 on 2024/03/24
//
//

import Foundation

public protocol WordListFileUseCaseType {

}

public class WordListFileUseCase: WordListFileUseCaseType {

    private let provider: RepositoryProviderType
    init(provider: RepositoryProviderType) {
        self.provider = provider
    }
}
