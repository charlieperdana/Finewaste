//
//  CircleNavigationBackButton.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import SwiftUI

struct CircleNavigationBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var additionalAction: () -> Void
    
    var body: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
            additionalAction()
        } label: {
            ZStack {
                Circle()
                    .fill(Colors.White)
                    .frame(width: 44, height: 44)
                    .opacity(0.7)
                Image(systemName: "chevron.backward")
                    .foregroundColor(Colors.Turqoise)
                    .font(.system(size: 23).weight(.medium))
            }
        }
    }
}

struct CircleNavigationBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleNavigationBackButton(additionalAction: {})
    }
}
