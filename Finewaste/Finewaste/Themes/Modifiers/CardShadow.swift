//
//  CardShadow.swift
//  Finewaste
//
//  Created by Andrean Lay on 12/01/22.
//

import SwiftUI

struct CardShadow: ViewModifier {
    @ViewBuilder func body(content: Content) -> some View {
        content
            .shadow(color: Colors.DropShadow.opacity(0.4), radius: 1, x: 2, y: 2)
            .shadow(color: Colors.DropShadow.opacity(0.4), radius: 1, x: -2, y: -2)
    }
}
