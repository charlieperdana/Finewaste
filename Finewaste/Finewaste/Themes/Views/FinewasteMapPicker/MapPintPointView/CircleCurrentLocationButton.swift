//
//  CircleCurrentLocationButton.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import SwiftUI

struct CircleCurrentLocationButton: View {
    var onTapAction: () -> Void
    
    var body: some View {
        Button(action: onTapAction) {
            ZStack {
                Circle()
                    .fill(Colors.White)
                    .frame(width: 44, height: 44)
                    .opacity(0.7)
                Image(systemName: "location")
                    .foregroundColor(Colors.Turqoise)
                    .font(.system(size: 23).weight(.medium))
            }
        }
    }
}

struct CircleCurrentLocationButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleCurrentLocationButton() {}
    }
}
