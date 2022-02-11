//
//  ErrorOccuredView.swift
//  Finewaste
//
//  Created by Andrean Lay on 04/02/22.
//

import SwiftUI

struct ErrorOccuredView: View {
    var onTapAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
         
            VStack(spacing: 24) {
                Image("ErrorOccured")
                    .frame(width: 197, height: 172)
                
                VStack(spacing: 8) {
                    Text("Oops, Something went wrong!")
                        .font(Fonts.poppinsCallout())
                    Text("We are looking into it. Please try again later.")
                        .font(Fonts.poppinsSubheadline())
                }
                
                FinewasteButtonFill(text: "Reload", size: .fullWidth, isEnabled: true, onButtonTap: onTapAction)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ErrorOccuredView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorOccuredView(onTapAction: {})
    }
}
