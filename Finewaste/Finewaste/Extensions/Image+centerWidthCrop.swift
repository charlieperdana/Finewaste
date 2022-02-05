//
//  View+centerWidthCrop.swift
//  Finewaste
//
//  Created by Andrean Lay on 08/11/21.
//

import Foundation
import SwiftUI
import Kingfisher

extension KFImage {
    func centerWidthCrop(width: CGFloat = -1, height: CGFloat = -1) -> some View {
        GeometryReader { geo in
            let smallerSideSize = geo.size.width < geo.size.height ? geo.size.width : geo.size.height
            
            self
                .resizable()
                .scaledToFill()
                .frame(width: width == -1 ? smallerSideSize : width, height: height == -1 ? smallerSideSize : height)
                .clipped()
        }
    }
    
    func cropToSize(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
    }
}

extension Image {
    func centerWidthCrop(width: CGFloat = -1, height: CGFloat = -1) -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: width == -1 ? geo.size.width : width, height: height == -1 ? geo.size.height : height)
                .clipped()
        }
    }
}
