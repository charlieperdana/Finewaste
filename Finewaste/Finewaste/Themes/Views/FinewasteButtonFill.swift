//
//  FinewasteButton.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct FinewasteButtonFill: View {
    var text: String
    var size: FinewasteButtonStyle
    var isEnabled: Bool
    var onButtonTap: () -> Void

    private var strokeColor: Color {
        isEnabled ? Colors.Turqoise : Colors.Gray
    }
    
    var body: some View {
        Button(action: onButtonTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(strokeColor)

                Text(text)
                    .font(Fonts.poppinsHeadline())
                    .foregroundColor(Colors.White)
            }
            .modifier(FinewasteButtonSize(size: size))
        }
        .disabled(!isEnabled)
    }
}

struct FinewasteButtonFill_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteButtonFill(text: "Chat", size: .fullWidth, isEnabled: false, onButtonTap: {})
    }
}
