//
//  ContentView.swift
//  
//  Created by Tatsumi0000 on 2024/03/26
//  
//

import SwiftUI
import RaelizeLogic
import Combine

struct ContentView: View {
    @State var inputText = ""
    
    var body: some View {
        VStack {
            TextField("Input text", text: $inputText)
        }.onAppear(perform: {
            UseCaseProvider.shared.wordListFileUseCase.readFile(fileName: "a")
            
            let cancellables =  UseCaseProvider.shared.wordListFileUseCase.currentWordList
                .sink(receiveValue: {
                    print("------sink------")
                    print($0)
                })
        })
        .padding()
        Button("Button", action: {
            UseCaseProvider.shared.wordListFileUseCase.searchWordList(word: inputText)
        })
    }
}

#Preview {
    ContentView()
}
