//
//  FinewasteButtonSize.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import Foundation
import SwiftUI

enum FinewasteButtonStyle {
    case small
    case fullWidth
}

struct FinewasteButtonSize: ViewModifier {
    var size: FinewasteButtonStyle

    @ViewBuilder func body(content: Content) -> some View {
        if size == .fullWidth {
            content
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44, maxHeight: 44)
        } else {
            content
                .frame(minWidth: 0, maxWidth: 104, minHeight: 44, maxHeight: 44)
        }
    }
}
