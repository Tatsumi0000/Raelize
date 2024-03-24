//
//  WordListFileRepository.swift
//
//  Created by Tatsumi0000 on 2024/03/24
//
//

import Foundation

protocol WordListFileRepositoryType {
    func readFile(fileName: String)
}

class WordListFileRepository: WordListFileRepositoryType {

    public func readFile(fileName: String) {
        print(fileName)
    }

}
