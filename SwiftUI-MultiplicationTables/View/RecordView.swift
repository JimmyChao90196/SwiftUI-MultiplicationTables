//
//  RecordView.swift
//  SwiftUI-MultiplicationTables
//
//  Created by JimmyChao on 2024/3/21.
//

import SwiftUI

struct RecordView: View {
    
    var questions: [Question]
    var finalRecords: [Question: Bool]
    var restartAction: () -> Void
    
    init(
        questions: [Question],
        finalRecords: [Question : Bool],
        restartAction: @escaping () -> Void) {
            self.questions = questions
            self.finalRecords = finalRecords
            self.restartAction = restartAction
        }
    
    var body: some View {
        VStack {
            
            List(questions, id: \.self) { question in
                HStack(alignment: .center) {
                    Text("\(question.question)")
                    Text("\(finalRecords[question, default: false] ? "Correct" : "Incorrect")")
                }
            }
            .scrollContentBackground(.hidden)
            
            Button("Restart") {
                
                restartAction()
                
            }
            .buttonStyle(.borderedProminent)
            .padding(40)
        }
    }
}
