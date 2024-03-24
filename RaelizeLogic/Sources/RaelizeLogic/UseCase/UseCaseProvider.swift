//
//  UseCaseProvider.swift
//
//  Created by Tatsumi0000 on 2024/03/24
//
//

import Foundation

public protocol UseCaseProviderType {
    var wordListFileUseCase: WordListFileUseCaseType { get }
}

public class UseCaseProvider: UseCaseProviderType {

    private init() {}
    public static let shared: UseCaseProviderType = UseCaseProvider()

    public var wordListFileUseCase: WordListFileUseCaseType = WordListFileUseCase(
        provider: RepositoryProvider.shared)
}
