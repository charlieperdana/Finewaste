//
//  FinewasteTextField.swift
//  Finewaste
//
//  Created by Andrean Lay on 07/11/21.
//

import SwiftUI

struct FinewasteTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Colors.Gray)
            TextField(placeholder, text: $text)
                .font(Fonts.poppinsSubheadline())
                .padding([.leading, .trailing], 16)
                .padding([.top, .bottom], 12)
        }
        .frame(height: 44)
    }
}

struct FinewasteTextField_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteTextField(placeholder: "Tell us your project update", text: .constant(""))
    }
}
