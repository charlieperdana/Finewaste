//
//  ChatTemplateView.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import SwiftUI

struct ChatTemplate: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(Fonts.poppinsSubheadline())
            .padding(12)
            .foregroundColor(Colors.Turqoise)
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .stroke(Colors.Turqoise, lineWidth: 1)
            )
            .cornerRadius(13)
    }
}

struct ChatTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        ChatTemplate(text: "")
    }
}
