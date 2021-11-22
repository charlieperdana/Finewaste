//
//  FinewasteLimitTextField.swift
//  Finewaste
//
//  Created by Andrean Lay on 19/11/21.
//

import SwiftUI

struct FinewasteLimitTextField: View {
    var placeholder: String
    @Binding var text: String
    var maximumCharacter: Int
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Colors.Gray)
                TextField(placeholder, text: $text)
                    .font(Fonts.poppinsSubheadline())
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 12)
                    .onChange(of: text) { newValue in
                        if newValue.count > maximumCharacter {
                            self.text = String(newValue.dropLast())
                        }
                    }
            }
            .frame(height: 44)
            
            HStack {
                Spacer()
                
                Text("\(text.count)/\(maximumCharacter)")
                    .foregroundColor(Colors.Turqoise)
                    .font(Fonts.poppinsFootnote())
            }
        }
    }
}

struct FinewasteLimitTextField_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteLimitTextField(placeholder: "", text: .constant(""), maximumCharacter: 100)
    }
}
