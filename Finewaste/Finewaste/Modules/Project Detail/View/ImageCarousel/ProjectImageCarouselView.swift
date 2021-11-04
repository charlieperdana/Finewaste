//
//  ProjectImageCarouselView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct ProjectImageCarouselView: View {
    @GestureState private var translation: CGFloat = 0
    
    @State private var currentPage = 0
    private let maxPage = 5
    
    var body: some View {
        ZStack {
            TabView(selection: $currentPage) {
                ForEach(0..<maxPage, id: \.self) { _ in
                    Image("exampleImage")
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                Spacer()
                ImagePageIndicatorView(currentPage: $currentPage, maximumPage: maxPage)
                    .onTapGesture {}
            }
            .padding()
        }
    }
}

struct ProjectImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectImageCarouselView()
    }
}
