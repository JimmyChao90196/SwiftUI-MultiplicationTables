//
//  Model.swift
//  SwiftUI-MultiplicationTables
//
//  Created by JimmyChao on 2024/3/21.
//

import Foundation

protocol QuestionProtocol {
    var baseNumber: Int { get set }
    var randomNumber: Int { get set }
    var question: String { get }
    var actualAnswer: Int { get }
}

struct Question: QuestionProtocol, Hashable {
    
    var id: String = UUID().uuidString
    var baseNumber: Int
    var randomNumber: Int
    
    var question: String {
        return "\(baseNumber) times \(randomNumber) = ?"
    }
    
    var actualAnswer: Int {
        return baseNumber * randomNumber
    }
    
}
