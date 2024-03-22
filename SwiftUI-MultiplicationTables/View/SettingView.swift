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
}

struct SettingView: View {
    
    var gameStart: () -> Void
    
    @State private var totalRound: Int = 3
    @State private var baseNumber: Int = 2
    
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
            }
            
            Button("Begin") {
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
        }
        .onChange(of: totalRound) { oldValue, newValue in
            delegate.updateTotalRound(with: newValue)
        }
        .onChange(of: baseNumber) { oldValue, newValue in
            delegate.updateBaseNumber(with: newValue)
        }
    }
}
