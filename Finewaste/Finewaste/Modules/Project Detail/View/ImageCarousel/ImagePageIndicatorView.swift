//
//  ImagePageIndicatorView.swift
//  Finewaste
//
//  Created by Andrean Lay on 03/11/21.
//

import SwiftUI

struct ImagePageIndicatorView: View {
    private let dotSize: CGFloat = 8.0
    private var backgroundWidth: CGFloat {
        let dotsSpace = self.dotSize * CGFloat(self.maximumNumOfPages)
        let margin = CGFloat(4 * self.maximumNumOfPages + 4)
        
        return dotsSpace + margin
    }
    private var maximumNumOfPages: Int
    
    @Binding var currentPage: Int
    
    init(currentPage: Binding<Int>, maximumPage: Int) {
        self._currentPage = currentPage
        self.maximumNumOfPages = maximumPage
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Colors.White)
                .opacity(0.5)
                .frame(width: backgroundWidth, height: 16)
            
            HStack(spacing: 4) {
                ForEach(0..<self.maximumNumOfPages, id: \.self) { pageIndex in
                    Circle()
                        .fill(pageIndex == currentPage ? Colors.Turqoise : Colors.White)
                        .opacity(pageIndex == currentPage ? 1.0 : 0.5)
                        .frame(width: dotSize, height: dotSize)
                        .onTapGesture {
                            withAnimation {
                                self.currentPage = pageIndex
                            }
                        }
                }
            }
        }
    }
}

struct ImagePageIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePageIndicatorView(currentPage: .constant(1), maximumPage: 4)
    }
}
