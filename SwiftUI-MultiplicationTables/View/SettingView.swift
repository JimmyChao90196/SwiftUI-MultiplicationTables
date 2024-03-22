//
//  SettingView.swift
//  SwiftUI-MultiplicationTables
//
//  Created by JimmyChao on 2024/3/21.
//

import SwiftUI

protocol SettingViewDelegation {
    func updateTotalRound(with totalRound: Int)
    func updateBaseNumber(with baseNumber: Int)
    func updateDifficulty(with difficulty: Difficulties)
}

enum Difficulties: String, CaseIterable{
    case easy
    case medium
    case hard
    
    var difficulty: Range<Int> {
        switch self {
        case .easy:
            return 0..<12
        case .medium:
            return 20..<100
        case .hard:
            return 100..<200
        }
    }
}

struct SettingView: View {
    
    var gameStart: () -> Void
    
    @State private var totalRound: Int = 3
    @State private var baseNumber: Int = 2
    @State private var difficulty: Difficulties = .easy
    
    @State private var allTransitionVal: Bool = true
    
    var delegate: SettingViewDelegation
    
    init(delegate: SettingViewDelegation,
         gameStart: @escaping () -> Void) {
        self.gameStart = gameStart
        self.delegate = delegate
    }
    
    var body: some View {
        
        VStack {
            
            List {
                Section("How many questions") {
                    Stepper("Now we have \(totalRound) questions", value: $totalRound)
                }
                
                Section("Choose a multiplication table") {
                    Stepper("Now we're playing \(baseNumber)", value: $baseNumber)
                }
                
                Section("Choose a difficulty") {
                    Picker("Let's play", selection: $difficulty) {
                        ForEach(Difficulties.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                }
            }
            
            Button("Begin") {
                allTransitionVal = false
                gameStart()
            }
            .buttonStyle(.borderedProminent)
            .padding(40)
        }
        .scrollContentBackground(.hidden)
        .frame(maxWidth: .infinity, maxHeight: 550)
        .onAppear {
            delegate.updateTotalRound(with: totalRound)
            delegate.updateBaseNumber(with: baseNumber)
            delegate.updateDifficulty(with: difficulty)
        }
        .onChange(of: totalRound) { oldValue, newValue in
            delegate.updateTotalRound(with: newValue)
        }
        .onChange(of: baseNumber) { oldValue, newValue in
            delegate.updateBaseNumber(with: newValue)
        }
        .onChange(of: difficulty) { oldValue, newValue in
            delegate.updateDifficulty(with: newValue)
        }
    }
}
