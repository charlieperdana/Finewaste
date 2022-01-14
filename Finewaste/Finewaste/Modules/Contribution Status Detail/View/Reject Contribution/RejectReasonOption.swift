//
//  RejectReasonOption.swift
//  Finewaste
//
//  Created by Andrean Lay on 15/11/21.
//

import SwiftUI

struct RejectReasonOption: View {
    var reason: String
    var isActive: Bool
    
    private var strokeColor: Color {
        return isActive ? Colors.Turqoise : Colors.Gray
    }
    
    var body: some View {
        HStack {
            Text(reason)
                .font(Fonts.poppinsBody())
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 70)
            
            Spacer()
            
            if isActive {
                Image(systemName: "checkmark")
                    .font(.system(size: 17).weight(.bold))
                    .foregroundColor(Colors.Turqoise)
            }
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(strokeColor)
        )
        .contentShape(Rectangle())
    }
}

struct RejectReasonOption_Previews: PreviewProvider {
    static var previews: some View {
        RejectReasonOption(reason: "Materials does not meet the requirements", isActive: true)
    }
}
