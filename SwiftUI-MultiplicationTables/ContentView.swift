//
//  ContentView.swift
//  SwiftUI-MultiplicationTables
//
//  Created by JimmyChao on 2024/3/20.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    let questionFactory = QuestionFactory()
    let scoreTracker = ScoreTracker()
    
    @State private var TotalRound: Int = 3
    @State private var baseNumber: Int = 2
    @State private var questions = [Question]()
    @State private var isRoundBegin = false
    @State private var isRoundEnded = false
    @State private var roundIndex = 0
    @State private var playerAnswer = 0
    @State private var finalRecords = [Question: Bool]()
    
    // Formatter
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                AngularGradient(colors: [.red, .green, .blue, .cyan, .red], center: .center).ignoresSafeArea()
                
                VStack(alignment: .center ,spacing: 20) {
                    
                    if !isRoundBegin {
                        List {
                            Section("How many questions") {
                                Stepper("Now we have \(TotalRound) questions", value: $TotalRound)
                            }
                            
                            Section("Choose a multiplication table") {
                                Stepper("Now we're playing \(baseNumber)", value: $baseNumber)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .frame(maxWidth: .infinity, maxHeight: 550)
                        .transition(.slide)
                    } else if isRoundEnded == false {
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
                    } else {
                        
                        List(questions, id: \.self) { question in
                            HStack {
                                Text("\(question.question)")
                                Text("\(finalRecords[question])")
                            }
                        }
                    }
                    
                    if !isRoundBegin {
                        Button("Begin") {
                            // Prepare questions for current round
                            questions = questionFactory.generateQuestions(
                                by: TotalRound,
                                and: baseNumber)
                            
                            scoreTracker.convertToRecords(questions: questions)
                            
                            isRoundBegin = true
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(40)
                        .transition(.scale)
                    } else if isRoundEnded == false{
                        Button("Next") {
                            checkRoundEnded()
                            askNextQuestion()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(40)
                    }
                }
                .background(.ultraThinMaterial)
                .frame(maxWidth: .infinity, maxHeight: 550)
                .clipShape(.rect(cornerRadius: 20))
                .padding()
                .onSubmit {
                    checkRoundEnded()
                    askNextQuestion()
                }
                .animation(.easeInOut, value: isRoundBegin)
                
            }.navigationTitle("Multiplication Game")
        }
    }
    // Game over
    func checkRoundEnded() {
        scoreTracker.checkCorrectness(
            questions: questions,
            currentIndex: roundIndex,
            playerAnswer: playerAnswer)
        
        guard roundIndex != (TotalRound - 1) else {
            
            finalRecords = scoreTracker.showRecords()
            isRoundEnded = true
            return
        }
        isRoundEnded = false
    }
    
    // Next question
    func askNextQuestion() {
        
        guard roundIndex != (TotalRound - 1) else { return }
        guard playerAnswer != 0 else { return }
        roundIndex += 1
        playerAnswer = 0
    }
}

#Preview {
    ContentView()
}
