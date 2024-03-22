//
//  QuestionView.swift
//  SwiftUI-MultiplicationTables
//
//  Created by JimmyChao on 2024/3/21.
//

import SwiftUI

protocol QuestionViewDelegation{
    func updatePlayerAnswer(with playerAnswer: Int)
}

struct QuestionView: View {
    
    @State private var playerAnswer: Int = 0
    
    // Normal property
    var questions: [Question]
    var roundIndex: Int
    
    // Delegation
    @State var delegate: QuestionViewDelegation
    
    // Closure
    var nextQuestion: () -> Void
    
    // Formatter
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    var body: some View {
        VStack {
            List {
                Section("Please answer the following question") {
                    Text(questions[roundIndex].question)
                        .multilineTextAlignment(.center)
                    TextField("Please type your answer here", value: $playerAnswer, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                }
            }
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: 550)
            .onChange(of: playerAnswer) {
                delegate.updatePlayerAnswer(with: playerAnswer)
            }
            
            Button("Next") {
                nextQuestion()
                playerAnswer = 0
            }
            .buttonStyle(.borderedProminent)
            .padding(40)
        }
        .onSubmit {
            nextQuestion()
            playerAnswer = 0
        }
    }
}

