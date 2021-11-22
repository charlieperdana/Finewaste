//
//  NavigationBackButton.swift
//  Finewaste
//
//  Created by Andrean Lay on 04/11/21.
//

import SwiftUI

struct NavigationBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: onBackButtonTapped) {
            Image(systemName: "chevron.left")
                .font(.system(size: 17).weight(.medium))
                .foregroundColor(Colors.Turqoise)
        }
    }
    
    private func onBackButtonTapped() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct NavigationBackButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBackButton()
    }
}
