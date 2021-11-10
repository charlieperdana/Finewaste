//
//  FinewasteOutlineButton.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct FinewasteRoundedOutlineButton: View {
    var text: String
    var size: FinewasteButtonStyle
    var onButtonTap: () -> Void
    
    var body: some View {
        Button(action: onButtonTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 13.0)
                    .stroke(Colors.Turqoise)
                
                Text(text)
                    .font(Fonts.poppinsSubheadline())
                    .foregroundColor(Colors.Turqoise)
            }
            .modifier(FinewasteButtonSize(size: size))
        }
    }
}

struct FinewasteOutlineButton_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteRoundedOutlineButton(text: "", size: .fullWidth) {

        }
    }
}
