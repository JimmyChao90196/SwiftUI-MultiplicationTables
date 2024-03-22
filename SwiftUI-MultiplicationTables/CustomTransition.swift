//
//  CustomTransition.swift
//  SwiftUI-MultiplicationTables
//
//  Created by JimmyChao on 2024/3/22.
//

import Foundation
import SwiftUI

struct rotateTransitionModifier: ViewModifier {
    
    var anchor: UnitPoint
    var degree: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(degree), anchor: anchor)
            .clipped()
    }
}


extension AnyTransition {
    
    static var customRotation: AnyTransition {
        AnyTransition.modifier(
            active: rotateTransitionModifier(anchor: .bottomTrailing, degree: 90),
            identity: rotateTransitionModifier(anchor: .bottomTrailing, degree: 0))
    }
}
