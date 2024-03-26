//
//  ContentView.swift
//
//  Created by Tatsumi0000 on 2024/03/26
//
//

import Combine
import RaelizeLogic
import SwiftUI

private var cancellables: Set<AnyCancellable> = []

struct ContentView: View {
    @State var inputText = ""

    var body: some View {
        VStack {
            TextField("Input text", text: $inputText)
        }
        .onAppear(perform: {
            UseCaseProvider.shared.wordListFileUseCase.readFile(fileName: "a")

            UseCaseProvider.shared.wordListFileUseCase.currentWordList
                .compactMap({ $0 })
                .sink(receiveValue: {
                    print("------sink------")
                    print($0)
                })
                .store(in: &cancellables)
        })
        .padding()
        Button(
            "Button",
            action: {
                UseCaseProvider.shared.wordListFileUseCase.searchWordList(word: inputText)
            })
    }
}

#Preview {
    ContentView()
}
