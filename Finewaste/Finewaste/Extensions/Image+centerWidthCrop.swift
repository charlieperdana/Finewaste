//
//  View+centerWidthCrop.swift
//  Finewaste
//
//  Created by Andrean Lay on 08/11/21.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

extension WebImage {
    func centerWidthCrop() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.width)
        }
    }
}
