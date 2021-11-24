//
//  FinewasteTapHoldButton.swift
//  Finewaste
//
//  Created by Andrean Lay on 15/11/21.
//

import SwiftUI

enum TapHoldButtonStyle {
    case fill
    case outline
}

struct FinewasteTapHoldButton: View {
    var text: String
    var style: TapHoldButtonStyle
    var onHoldDoneAction: () -> Void
    
    @GestureState var isDetectingLongPress = false
    
    var body: some View {
        ZStack {
            if style == .fill {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Colors.Turqoise)
            } else {
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(Colors.Turqoise)
            }
            
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Colors.Black)
                .opacity(0.2)
                .frame(
                    minWidth: 0,
                    maxWidth: isDetectingLongPress ? .infinity : 0,
                    minHeight: 44,
                    maxHeight: 44)
                .animation(.easeInOut(duration: 2.0))
            
            Text(text)
                .font(Fonts.poppinsHeadline())
                .foregroundColor(style == .fill ? Colors.White : Colors.Turqoise)
        }
        .contentShape(Rectangle())
        .modifier(FinewasteButtonSize(size: .fullWidth))
        .gesture(
            LongPressGesture(minimumDuration: 2.0)
                .updating($isDetectingLongPress) { currentState, gestureState, _ in
                    gestureState = currentState
                }
                .onEnded { _ in
                    onHoldDoneAction()
                }
        )
    }
}

struct FinewasteTapHoldButton_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteTapHoldButton(text: "Hold to Confirm", style: .fill, onHoldDoneAction: {})
    }
}
