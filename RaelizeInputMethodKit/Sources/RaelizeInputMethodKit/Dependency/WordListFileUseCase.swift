//
//  WordListFileUseCase.swift
//
//  Created by Tatsumi0000 on 2024/04/13
//
//

import Dependencies
import Foundation
import RaelizeLogic

private enum WordListFileUseCaseKey: DependencyKey {
    static let liveValue: any WordListFileUseCaseType = UseCaseProvider.shared.wordListFileUseCase
}

extension DependencyValues {
    public var wordListFileUseCase: any WordListFileUseCaseType {
        get { self[WordListFileUseCaseKey.self] }
        set { self[WordListFileUseCaseKey.self] = newValue }
    }
}
