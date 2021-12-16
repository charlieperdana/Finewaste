//
//  FinewasteDialog.swift
//  Finewaste
//
//  Created by Andrean Lay on 16/12/21.
//

import SwiftUI

struct FinewasteDialog: View {
    var text: String
    var onButtonTap: () -> Void
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black
                .opacity(0.4)
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text(text)
                        .font(Fonts.poppinsFootnote())
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.black)

                    FinewasteButtonOutline(text: "Ok", size: .fullWidth, isEnabled: true, onButtonTap: onButtonTap)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                )
            }
            .padding(32)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct FinewasteDialog_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteDialog(text: "", onButtonTap: {})
    }
}
