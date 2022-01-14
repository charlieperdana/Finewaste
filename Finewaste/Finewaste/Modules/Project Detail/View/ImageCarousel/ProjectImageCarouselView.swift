//
//  ProjectImageCarouselView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProjectImageCarouselView: View {
    var images: [String]
    
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $currentPage) {
                ForEach(0..<images.count, id: \.self) { index in
                    WebImage(url: URL(string: images[index]))
                        .centerWidthCrop()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                Spacer()
                ImagePageIndicatorView(currentPage: $currentPage, maximumPage: images.count)
                    .onTapGesture {}
            }
            .padding()
        }
    }
}

struct ProjectImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectImageCarouselView(images: [])
    }
}
