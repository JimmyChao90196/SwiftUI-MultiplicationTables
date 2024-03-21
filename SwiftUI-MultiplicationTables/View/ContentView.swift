//
//  ContentView.swift
//  SwiftUI-MultiplicationTables
//
//  Created by JimmyChao on 2024/3/20.
//

import SwiftUI
import Foundation

struct ContentView: 
    View,
    SettingViewDelegation,
    QuestionViewDelegation {
    
    let questionFactory = QuestionFactory()
    let scoreTracker = ScoreTracker()
    
    @State private var totalRound: Int = 3
    @State private var baseNumber: Int = 2
    @State private var questions = [Question]()
    @State private var isRoundBegin = false
    @State private var isRoundEnded = false
    @State private var roundIndex = 0
    @State private var playerAnswer = 0
    @State private var finalRecords = [Question: Bool]()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                AngularGradient(
                    colors: [.red, .green, .blue, .cyan, .red],
                    center: .center)
                .ignoresSafeArea()
                
                VStack(alignment: .center ,spacing: 20) {
                    
                    if !isRoundBegin {
                        
                        SettingView(delegate: self)
                        
                    } else if isRoundEnded == false {
                        
                        QuestionView(
                            questions: questions,
                            roundIndex: roundIndex,
                            delegate: self)
                        
                    } else {
                        
                        VStack {
                            
                            List(questions, id: \.self) { question in
                                HStack(alignment: .center) {
                                    Text("\(question.question)")
                                    Text("\(finalRecords[question, default: false] ? "Correct" : "Incorrect")")
                                }
                            }
                            .scrollContentBackground(.hidden)
                            
                            Button("Restart") {
                                isRoundBegin = false
                                isRoundEnded = false
                                finalRecords = [Question: Bool]()
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(40)
                        }
                    }
                    
                    if !isRoundBegin {
                        Button("Begin") {
                            // Prepare questions for current round
                            questions = questionFactory.generateQuestions(
                                by: totalRound,
                                and: baseNumber)
                            
                            scoreTracker.convertToRecords(questions: questions)
                            roundIndex = 0
                            playerAnswer = 0
                            
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
        
        guard roundIndex != (totalRound - 1) else {
            
            finalRecords = scoreTracker.showRecords()
            isRoundEnded = true
            return
        }
        isRoundEnded = false
    }
    
    // Next question
    func askNextQuestion() {
        
        guard roundIndex != (totalRound - 1) else { return }
        roundIndex += 1
        playerAnswer = 0
    }
    
    // Delegation
    func updateBaseNumber(with baseNumber: Int) {
        self.baseNumber = baseNumber
    }
    func updateTotalRound(with totalRound: Int) {
        self.totalRound = totalRound
    }
    
    func updatePlayerAnswer(with playerAnswer: Int) {
        self.playerAnswer = playerAnswer
    }
}

#Preview {
    ContentView()
}
