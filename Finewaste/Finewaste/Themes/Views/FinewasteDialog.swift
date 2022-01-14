//
//  FinewasteDialog.swift
//  Finewaste
//
//  Created by Andrean Lay on 16/12/21.
//

import SwiftUI

struct FinewasteDialog: View {
    var headerText: String
    var dialogText: String
    var onButtonTap: () -> Void
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black
                .opacity(0.4)
            ZStack {
                VStack(alignment: .center, spacing: 20) {
                    Text(headerText)
                        .font(Fonts.poppinsHeadline())
                        .foregroundColor(Colors.Red)
                    Text(dialogText)
                        .font(Fonts.poppinsFootnote())
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)

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
        FinewasteDialog(headerText: "", dialogText: "", onButtonTap: {})
    }
}
