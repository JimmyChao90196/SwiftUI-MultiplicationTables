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
    
    // View as property
    @State var questionView: QuestionView?
    
    var body: some View {

        NavigationStack {
            ZStack {
                AngularGradient(
                    colors: [.red, .green, .blue, .cyan, .red],
                    center: .center)
                .ignoresSafeArea()
                
                VStack(alignment: .center ,spacing: 20) {
                    
                    if !isRoundBegin {
                        
                        let settingView = SettingView(delegate: self) {
                            prepareForGameStart()
                        }
                        
                        settingView.transition(.customRotation)
                                                
                    } else if isRoundEnded == false {
                        
                        let questionView = QuestionView(
                            questions: questions,
                            roundIndex: roundIndex,
                            delegate: self) {
                                checkRoundEnded()
                                askNextQuestion()
                            }
                        
                        questionView.transition(.opacity)
                        
                    } else {
                        
                        RecordView(
                            questions: questions,
                            finalRecords: finalRecords) {
                                isRoundBegin = false
                                isRoundEnded = false
                                finalRecords = [Question: Bool]()
                            }
                    }

                }
                .background(.ultraThickMaterial)
                .frame(maxWidth: .infinity, maxHeight: 550)
                .clipShape(.rect(cornerRadius: 20))
                .padding()
                .animation(.easeInOut, value: isRoundEnded)
                .animation(.easeInOut, value: isRoundBegin)
                
            }.navigationTitle("Multiplication Game")
        }
    }
    // Game start
    func prepareForGameStart() {
        // Prepare questions for current round
        questions = questionFactory.generateQuestions(
            by: totalRound,
            and: baseNumber)
        
        // Create a records at the beginning
        scoreTracker.convertToRecords(questions: questions)
        roundIndex = 0
        playerAnswer = 0
        isRoundBegin = true
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
    
    func updateDifficulty(with difficulty: Difficulties) {
        questionFactory.defaultRange = difficulty.difficulty
    }
}

class ViewDelegation {
    
}

#Preview {
    ContentView()
}
