//
//  BulletColor.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import SwiftUI

struct StepBulletColor: ViewModifier {
    var currentStep: Int
    var onGoingStep: Int
    var maxStep: Int
    
    @ViewBuilder func body(content: Content) -> some View {
        if currentStep < onGoingStep {
            content
                .foregroundColor(Colors.Pink)
        } else if currentStep == onGoingStep {
            content
                .foregroundColor(Colors.Red)
        } else {
            content
                .foregroundColor(Colors.Gray)
        }
    }
}
