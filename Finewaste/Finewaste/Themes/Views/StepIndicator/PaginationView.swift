//
//  PaginationView.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import SwiftUI

struct PaginationView: View {
    @Binding var currentStep: Int
    var maxStep = 3
    var stepPlaceholder: [String]

    var body: some View {
        ZStack {
            HStack(spacing: 20) {
                ForEach(1..<maxStep) { step in
                    Rectangle()
                        .fill(step < currentStep ? Colors.Pink : Colors.Gray)
                        .frame(width: 85, height: 3)
                }
            }
            .offset(y: -10)
            
            HStack(spacing: 40) {
                ForEach(1..<maxStep + 1) { step in
                    StepBullet(forStep: step,
                               text: stepPlaceholder[step - 1],
                               isActivated: currentStep >= step)
                    .modifier(StepBulletColor(currentStep: step, onGoingStep: currentStep, maxStep: maxStep))
                }
            }
        }
    }
}

struct PaginationView_Previews: PreviewProvider {
    static var previews: some View {
        PaginationView(currentStep: .constant(2), maxStep: 3, stepPlaceholder: [])
    }
}
