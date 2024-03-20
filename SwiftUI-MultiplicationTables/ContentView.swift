//
//  ContentView.swift
//  SwiftUI-MultiplicationTables
//
//  Created by JimmyChao on 2024/3/20.
//

import SwiftUI
import Foundation

struct Question {
    
    var baseNumber: Int
    var randomNumber: Int
    
    var questions: String {
        return "\(baseNumber) times \(randomNumber)"
    }
    var answer: Int {
        return baseNumber * randomNumber
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    func generateRandomNumbers(by num: Int) -> [Int]{
        
        var randNumbers = [Int]()
        
        for i in 0..<num {
            let randNumber = Int.random(in: 0...12)
            randNumbers.append(randNumber)
        }
        
        return randNumbers
    }
}

#Preview {
    ContentView()
}
