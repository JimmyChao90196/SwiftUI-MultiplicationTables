//
//  ScoreManager.swift
//  SwiftUI-MultiplicationTables
//
//  Created by JimmyChao on 2024/3/21.
//

import Foundation

class ScoreTracker {
    
    private var questions = [Question]()
    private var records = [Question: Bool]()
    
    // Check correctness
    func checkCorrectness(
        questions: [Question],
        currentIndex: Int,
        playerAnswer: Int) {
            
            guard playerAnswer != 0 else { return }
            
            // Check correctness
            self.questions = questions
            let actaulAnswer = self.questions[currentIndex].actualAnswer
            let currentQuestion = self.questions[currentIndex]
            
            if actaulAnswer == playerAnswer {
                records[currentQuestion] = true
            } else {
                records[currentQuestion] = false
            }
    }
    
    func convertToRecords(questions: [Question]) {
        records = questions.reduce(into: [Question: Bool](), { partialResult, question in
            partialResult[question] = false
        })
    }
    
    // Spit out the answer
    func showRecords() -> [Question: Bool] {
        records
    }
    
}
