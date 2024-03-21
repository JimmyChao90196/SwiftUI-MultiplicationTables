//
//  QuestionManager.swift
//  SwiftUI-MultiplicationTables
//
//  Created by JimmyChao on 2024/3/21.
//

import Foundation

protocol QuestionFactoryProtocol {
    
    func generateQuestions(by num: Int, and baseNum: Int) -> [Question]
}

class QuestionFactory: QuestionFactoryProtocol {
    
    // Private property
    private var randomNumbers = [Int]()
    
    func generateQuestions(by questionNum: Int, and baseNum: Int) -> [Question] {
        
        var questions = [Question]()
        
        randomNumbers = generateRandomNumbers(by: questionNum)
        randomNumbers.forEach { randNum in
            let question = Question(baseNumber: baseNum, randomNumber: randNum)
            questions.append(question)
        }
        
        return questions
    }
    
    // Private function
    private func generateRandomNumbers(by num: Int) -> [Int] {
        var randNumbers = [Int]()
        for _ in 0..<num {
            let randNumber = Int.random(in: 0...12)
            randNumbers.append(randNumber)
        }
        
        return randNumbers
    }
}
