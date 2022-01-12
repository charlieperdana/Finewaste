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
    func centerWidthCrop(width: CGFloat = -1, height: CGFloat = -1) -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: width == -1 ? geo.size.width : width, height: height == -1 ? geo.size.height : height)
        }
    }
    
    func cropToSize(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
    }
}
