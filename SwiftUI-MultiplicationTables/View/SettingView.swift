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
    
    @State private var totalRound: Int = 3
    @State private var baseNumber: Int = 2
    
    var delegate: SettingViewDelegation
    
    var body: some View {
        List {
            Section("How many questions") {
                Stepper("Now we have \(totalRound) questions", value: $totalRound)
            }
            
            Section("Choose a multiplication table") {
                Stepper("Now we're playing \(baseNumber)", value: $baseNumber)
            }
        }
        .scrollContentBackground(.hidden)
        .frame(maxWidth: .infinity, maxHeight: 550)
        .transition(.slide)
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
